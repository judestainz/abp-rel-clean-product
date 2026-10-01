# abp-rel-clean-product

## Purpose

A throwaway demonstration product for the Autonomous Build Platform team-collaboration release (BC-M9-085 clean-station demonstration). It contains
dummy content only and will be archived or deleted after the demonstration. Everything here is public.

## Learning objectives

See how a team of teammates and an ABP station request, implement, review and publish changes to a small product through
GitHub issues and pull requests.

## Contents

- `packages/product/greeting.mjs` — the dummy product module.
- `packages/product/test/greeting.test.mjs` — its test.
- `package.json` — the `npm test` script.
- `.github/workflows/ci.yml` — the CI job `test`, the required check on `main`.

## Public API

`greeting(name)` returns the string `"Hello, <name>!"`.

## Data or control flow

A caller passes a name to `greeting`, which returns the formatted string. There is no state and no I/O.

## Usage examples

```js
import { greeting } from "./packages/product/greeting.mjs";
console.log(greeting("team")); // Hello, team!
```

## Testing

Run `npm test` from the repository root. The same command runs in CI as the required `test` check.

## Error handling

The module performs no validation; the test fails with an assertion diff if the greeting text changes.

## Assumptions

Node.js 22 or newer. Dummy content only: never add real code, credentials or customer data.

## Extension guide

Add new functions beside `greeting` in `packages/product/`, with a test in `packages/product/test/`. Changes reach `main`
only through a pull request that passes the `test` check.

## Related files

`package.json`, `.github/workflows/ci.yml`, `packages/product/greeting.mjs`, `packages/product/test/greeting.test.mjs`.
