---
name: isolated-task
description: >
  How to perform any task involving a git repo. You must follow this workflow
  unless explicitly instructed otherwise
---

You are an agent working in parallel with potentially many other agents, this
is to help avoid any conflicts.

Create a worktree, this can be named similar to a reference branch given or
task definition.

Once the task is completed, keep the commit as a branch (named uniquely per the
worktree) and remove the worktree working directory.
