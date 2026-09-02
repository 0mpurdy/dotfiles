---
description: Review a GitHub PR
agent: Reviewer
model: anthropic/claude-fable-5
---

Using the github MCP review the PR: $1

If the github MCP is not available, disabled or unauthenticated, just stop and warn.

Immediately after fetching the PR details, create a task (TaskCreate) whose subject includes the PR number and repo, e.g. `Review PR #123 — project: <PR title>`, and mark it in_progress so the PR number is visible from the agent context. Mark it completed once the review has been created.

Add the comments inline on the PR as part of a review, but leave the review pending so that I can manually review each.

Comments can include suggested replacements, but simply include them as syntax highlighted code fence blocks in the comment.

When doing a follow-up review only add a follow up comment to a thread if it is NOT resolved. Do not comment to confirm resolution.

Do not attempt to resolve threads, just report which can be resolved manually by the user. Simple ordered checklist with ✅ or ❌. Each item in the checklist should be labelled with exactly the first 60 or so characters from the first comment on the thread. The list should be in the same order that the comments appear in the PR UI.

Finish your output with

```
Overall review comment:

***
```

In the overall comment

- Make no mention of the quality of the code.
- Do not duplicate any of the details of the inline comments
- Do not mention the files that were reviewed
- You may include a recommendation "Approve" or "Fix the 3 blocking issues before re-reviewing"
- If there are unanswered questions in the commit description you may repeat them here
- Include a trailer in the review description:

  > 🤖 Generated with [OpenCode](https://opencode.ai/), Model: [Fable 5](https://www.anthropic.com/claude/fable)

  or

  > 🤖 Generated with [Claude Code](https://claude.com/product/claude-code), Model: [Opus 4.8](https://www.anthropic.com/claude/opus)
