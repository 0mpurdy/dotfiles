---
description: Review a GitHub PR
agent: Reviewer
model: anthropic/claude-fable-5
---

Using the github MCP review the PR: $1

If the github MCP is not available, disabled or unauthenticated, just stop and warn.

Add the comments inline on the PR as part of a review, but leave the review pending so that I can manually review each.

Comments can include suggested replacements, but simply include them as syntax highlighted code fence blocks in the comment.

When doing a follow-up review only add a follow up comment to a thread if it is NOT resolved

Do not attempt to resolve threads, just report which can be reslved manually by the user. Simple ordered checklist with ✅ or ❌

Finish your output with

```
Overall review comment:

***
```

In the overall comment

- Make no mention of the quality of the code.
- Do not duplicate any of the details of the inline comments
- Include a trailer in the review description:

  > 🤖 Generated with [OpenCode](https://opencode.ai/), Model: [Fable 5](https://www.anthropic.com/claude/fable)

  or

  > 🤖 Generated with [Claude Code](https://claude.com/product/claude-code), Model: [Opus 4.8](https://www.anthropic.com/claude/opus)
