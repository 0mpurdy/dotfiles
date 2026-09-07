---
description: Write k8s progress
---

Another agent may be working in the background implementing some changes and similarly writing progress, be careful not to interfere with what they may be doing.

For simple work like plans, write an appropriate file to `/agent-output`.

For work involving git, use the git commit skill then write a format-patch style file to `/agent-output` with all commits in a single file. This should be relative to the first Merge Pull Request ancestor commit.

After completion give the kubectl command to pull the file off your pod (or pvc). (Use $HOSTNAME to figure out your exact hostname in the command. The namespace is `mp`)

e.g. `kubectl cp mp/mp-opencode-846b78c6c6-pfb5d:agent-output/support-messaging-plan.md ./support-messaging-plan.md`
