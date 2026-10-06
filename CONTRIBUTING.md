# Contributing

<!-- Generated contributor kit v2 (policy sha256:f41137c32fe0c6fa15d6e317d1e3cc7dfbf6bd3fb5a6e942014534af8473cd28). Refreshed only by governed upgrade commits; do not edit by hand. -->

This product is built with a review-and-integration station. You can ask it for work, or implement an approved brief yourself with your own tools and AI assistant.

## Quick start

```sh
git clone https://github.com/judestainz/abp-rel-clean-product.git
sh scripts/contributor-check.sh doctor
sh scripts/contributor-check.sh setup
sh scripts/contributor-check.sh check
```

## Asking for work

Open an issue with one of the issue forms: `plan-and-implement`, `plan-only`, `review-and-integrate`. "Plan only" returns a portable brief you implement yourself; the other forms ask the station to implement, or to review and integrate an existing pull request.

## Asking the station for a change

Open the Request issue form and describe what you want in plain words. Read [the request guide](docs/REQUEST_GUIDE.md) for drafting and confirmation.

Your AI can follow [the complete structured sample](docs/REQUEST_SAMPLE.md) to submit a request directly. The station supplies validation; do not specify tests, budgets or reviewers in a request.

## Task briefs and submission

Work starts from a versioned, plan-only brief the station posts on a request issue (open one with the "Plan only" issue form). A brief names the exact base commit, the task ids, acceptance criteria, the paths you may change, contracts, docs and the commands above.

1. Start from `master` at exactly the brief's base commit. If `master` has moved, ask for a fresh brief on the issue rather than rebasing silently; a submission against a stale brief version or base is detected and judged against the current one.
2. Change only the paths the brief lists. Keep out of scope what the brief excludes.
3. Run `sh scripts/contributor-check.sh check` and fix every `FAIL` line.
4. Open one pull request against `master`. Its title follows `[brief-<issue> v<version>] <summary>` and its body carries the line `Implements-Brief: brief-<issue>@v<version> base=<exact base commit>`, exactly as the brief spells it.
5. The station imports your exact base and head, validates the candidate in its sandbox, has it independently reviewed and integrates it. Your pull request closes as absorbed only after a linked publication commit actually delivers the accepted result.

## Local checks versus station-only checks

Run these locally before you submit (`sh scripts/contributor-check.sh check` runs all of them):

- `npm test`

These run ONLY on the station, after you submit. The script prints them as `STATION-ONLY ... not run locally`; never report them as passed:

- none declared

The station re-runs its trusted checks on the exact commit you submit, whatever was reported locally:

- `test` — required, mirrored by the local checks above

## Supported hosts and dependencies

Platforms: linux, darwin. Architectures: x64, arm64.

- `node` 22.0 or newer — Install Node.js 22 or newer from https://nodejs.org

`sh scripts/contributor-check.sh doctor` checks all of this and says exactly what is missing or unsupported. It exits 3 for a missing or too-old dependency and 4 for an unsupported or unmeasurable host; it never reports a host it cannot judge as ready.

## Script exit codes

- 0: ready (doctor, setup) or every local check passed (check)
- 1: a setup step or a local check failed
- 2: unknown mode
- 3: a required dependency is missing or too old
- 4: the host platform, architecture or memory is unsupported or cannot be measured

## Read

- `README.md`
