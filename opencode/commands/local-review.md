---
description: Review the local changes on the current branch
agent: Reviewer
model: anthropic/claude-fable-5
---

Review the local changes: the diff of the current branch against the latest merge commit, plus any uncommitted changes. $1 may narrow the scope or name a different base ref.

Do not rely on `main` being the base it is almost certainly out of date, look in the history of the branch for the first mention of a merged PR, consider that the base.

Review only — do not modify any files.

Report each finding as its own comment headed by `path/to/file:line`. Suggested replacements go in syntax-highlighted code fence blocks within the comment.

Finish your output with

```
Overall review comment:

***
```

In the overall comment make no mention of the quality of the code and do not duplicate any of the details of the inline comments.
