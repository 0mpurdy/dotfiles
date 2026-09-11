---
name: mcp-oauth-headless
description: Complete an OAuth flow for a remote MCP server (opencode mcp auth) from inside a container
---

# Authorising an MCP server headlessly

OpenCode's OAuth callback server binds **`127.0.0.1:19876`** inside the container
(path `/mcp/oauth/callback`) and waits **5 minutes**. In a container there is no
browser, and the host browser's redirect to `127.0.0.1:19876` never reaches the
container. The fix is to relay the authorization code by hand.

Two facts that cause most failures:

- `ensureRunning` **silently no-ops if port 19876 is already in use**. A stale
  `opencode mcp auth` process from an earlier attempt will own the socket, the
  new flow gets no listener, and the callback 400s with
  `Invalid or expired state parameter`.
- The authorization code typically expires in **30–60s**, well before the
  5-minute listener timeout. Steps 4 and 5 must be quick.

## Steps

### 1. Kill stale flows and confirm the port is free

```bash
for p in $(ps -eo pid,cmd | awk '/[m]cp auth/{print $1}'); do kill -9 $p; done
python3 -c "print([int(l.split()[1].split(':')[1],16) for l in open('/proc/net/tcp').read().splitlines()[1:] if l.split()[3]=='0A'])"
```

`19876` must **not** appear in the list. Do not skip this.

### 2. Clear any half-finished attempt

```bash
opencode mcp logout <server>
```

Removes a stale `oauthState`/`codeVerifier` from `~/.local/share/opencode/mcp-auth.json`.

### 3. Start exactly one flow and verify it owns the socket

```bash
(setsid opencode mcp auth <server> > /tmp/auth.log 2>&1 < /dev/null &)
sleep 14
grep -ao 'https://[^ ]*authorize?[^ ]*' /tmp/auth.log | head -1
```

Confirm one process holds port 19876 before handing the URL over:

```bash
python3 - <<'EOF'
import os, glob
ino = {int(l.split()[1].split(':')[1],16): l.split()[9]
       for l in open('/proc/net/tcp').read().splitlines()[1:] if l.split()[3]=='0A'}.get(19876)
owner = next((p.split('/')[-1] for p in glob.glob('/proc/[0-9]*')
              for fd in os.listdir(p+'/fd') if os.readlink(p+'/fd/'+fd) == 'socket:[%s]' % ino), None)
print("listening:", bool(ino), "owner pid:", owner)
EOF
```

The `state=` in the printed URL must match `oauthState` in `mcp-auth.json`.

### 4. Approve in a browser on the host

Open the printed authorize URL. After approving, the browser fails with
"can't connect to the server" on a `127.0.0.1:19876` URL. **Copy that whole URL
from the address bar** — it carries `code` and `state`.

### 5. Replay the callback inside the container

```bash
curl -s -o /tmp/cb.html -w "HTTP %{http_code}\n" "<pasted URL>"
```

Expect `HTTP 200` and "Authorization successful". On a non-200, read the body —
it names the failure:

```bash
python3 -c "
import re,html; s=open('/tmp/cb.html').read()
s=re.sub(r'(?s)<[^>]+>',' ',re.sub(r'(?is)<(script|style).*?</\1>','',s))
print(re.sub(r'\s+',' ',html.unescape(s)).strip()[:300])"
```

| Response | Cause |
|---|---|
| `400` invalid/expired state | Stale process owns the socket (step 1), or the flow timed out |
| Connection refused | Flow already exited — restart from step 1 |
| `400` no authorization code | Copied the URL before approving |
