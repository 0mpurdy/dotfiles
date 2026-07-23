---
description: Review a GitHub PR
agent: Reviewer
model: anthropic/claude-fable-5
---

Using the github MCP review the PR: $1

If the github MCP is not available, disabled or unauthenticated, just stop and warn.

Add the comments inline on the PR as part of a review, but leave the review pending so that I can manually review each.

Comments can include suggested replacements, but simply include them as syntax highlighted code fence blocks in the comment.
