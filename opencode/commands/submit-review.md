---
description: Submit a completed review
agent: Reviewer
model: anthropic/claude-fable-5
---

This assumes that a review has been completed using the `/review` skill and that the user has explicitly requested finalizing the review.

If those assumptions do not hold, stop.

Submit the review, in the main review comment:

- Make no mention of the quality of the code.
- Include a trailer in the review description:

  > 🤖 Generated with [OpenCode](https://opencode.ai/)
