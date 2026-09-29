---
name: execute-plan
description: Playbook for executing plans
---

# Locating the plan

Execute the plan in `/agent-output`. If that directory does not exist or holds
no plan files, fall back to `.opencode/plans`. If no plan is specified,
enumerate the plans you found so that the user can choose just by number.

State which file you are executing before reading it.

# Environment

Note that you are in a docker container and all tests or tools that require
connection to external containers cannot work. Instead run explicitly locally
(e.g. `cd ui/ && npx eslint .` instead of `make -C ui lint`) where appropriate.
Some skills may help here such as `test-with-db` when the time comes.

Focus on a test driven development flow, write the tests to achieve the goal
first, then verify that they fail. Then implement the minimum needed to pass
the tests. Then refactor if necessary.

Read the `isolated-task` skill before continuing.

# Workflow

Focus on a test driven development flow, write the tests to achieve the goal
first, then verify that they fail. Then implement the minimum needed to pass
the tests. Then refactor if necessary.

Do quick searches for all new methods or components being added which may have
a shared version that exists already. Use the shared version always.
