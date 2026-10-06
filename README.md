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
- `.github/workflows/ci.yml` — the CI job `test`, the required check on `master`.

## Public API

`greeting(name)` returns the string `"Hello, <name>!"`. The substitution is unconditional, so every string `name` is a
valid argument — including `""`, which yields `"Hello, !"`.

## Data or control flow

A caller passes a name to `greeting`, which returns the formatted string. There is no state and no I/O.

## Usage examples

```js
import { greeting } from "./packages/product/greeting.mjs";
console.log(greeting("team")); // Hello, team!
console.log(greeting("Ada")); // Hello, Ada!
console.log(greeting("")); // Hello, !
```

Each call returns a new string and leaves nothing behind, so calling `greeting` twice with different names gives
`"Hello, team!"` and then `"Hello, Ada!"`.

The empty-name call is not a mistake in the example. `greeting("")` interpolates the empty string where the name would
go and returns exactly `"Hello, !"` — the literal `"Hello, "`, then `"!"`, with nothing between the comma-space and the
exclamation mark.

## Testing

Run `npm test` from the repository root to run every test file. The same command runs in CI as the required `test`
check that guards `master`.

To run the single greeting test file on its own, without the `npm test` wrapper:

```sh
node --test packages/product/test/greeting.test.mjs
```

## Error handling

The module performs no validation; the test fails with an assertion diff if the greeting text changes.

An empty name is therefore **accepted, not rejected**. `greeting("")` does not throw, does not return an error value
and does not substitute a default name such as `"there"` or `"world"`; it returns the ordinary string `"Hello, !"` like
any other call. Callers that need an empty name to be refused, or replaced by a fallback, must check the name
themselves before calling `greeting`.

## Assumptions

Node.js 22 or newer. Dummy content only: never add real code, credentials or customer data.

## Extension guide

Add new functions beside `greeting` in `packages/product/`, with a test in `packages/product/test/`. Changes reach
`master` — the protected branch — only through a pull request that passes the `test` check.

## Related files

`package.json`, `.github/workflows/ci.yml`, `packages/product/greeting.mjs`, `packages/product/test/greeting.test.mjs`.
