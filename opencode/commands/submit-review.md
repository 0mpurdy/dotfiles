---
description: Submit a completed review
---

This assumes that a review has been completed using the `/review` skill and that the user has explicitly requested finalizing the review.

If those assumptions do not hold, stop.

Submit the review, in the main review comment:

- Make no mention of the quality of the code.
- Do not duplicate any of the details of the inline comments
- Include a trailer in the review description:

  > 🤖 Generated with [OpenCode](https://opencode.ai/), Model: [Fable 5](https://www.anthropic.com/claude/fable)

  or

  > 🤖 Generated with [Claude Code](https://claude.com/product/claude-code), Model: [Opus 4.8](https://www.anthropic.com/claude/opus)
