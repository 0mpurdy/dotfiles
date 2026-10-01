---
description: Write k8s progress
---

Another agent may be working in the background implementing some changes and similarly writing progress, be careful not to interfere with what they may be doing.

For simple work like plans, write an appropriate file to `/agent-output`. Group files into directories with short names for multiple parts of a related task.

For work involving git, use the git commit skill then write a format-patch style file to `/agent-output` with all commits in a single file. This should be relative to the first Merge Pull Request ancestor commit.
