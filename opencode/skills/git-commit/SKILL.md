---
name: git-commit
description: Mandatory etiquette for committing
---

# Title

Do not use prefixes such as "fix: " or "refactor: "

# Ticket reference

Always check if a ticket reference should be included. The tickets should be
the last thing in the commit message just before the trailer, each ticket
reference should be on a separate line.

The ticket must be in the jira format project code, hyphen, ticket number.

If you cannot determine the project code from existing context, ask the user.

e.g.

```
TIC-00
TIC-000
```

# Trailer

LLM generated commits should include trailer for as many relevant co-authors as required.

For example the OpenCode tool using Claude Opus 4.6 would use a trailer such as:

```
Co-Authored-By: OpenCode <noreply@opencode.ai>
Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
```

Check which model you are using and replace with the appropriate one.
