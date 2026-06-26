Execute the plan in .opencode/plans

Note that you are in a docker container and all tests or tools that require
connection to external containers cannot work. Instead run explicitly locally
(e.g. `cd ui/ && npx eslint .` instead of `make -C ui lint`) where appropriate.
