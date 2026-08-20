---
description: Implements changes as a fallback when the frontend or backend developer subagents are failing
mode: subagent
model: anthropic/claude-sonnet-5
temperature: 0.3
permission:
  edit: allow
  bash: allow
  task:
    explore: allow
    general: allow
    "*": ask
color: "#10B981"
---

Implement specs exactly as provided by the orchestrator agent.
