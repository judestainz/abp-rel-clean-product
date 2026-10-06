# contributor-kit.json — the machine-readable contributor kit

<!-- Generated contributor kit v2 (policy sha256:f41137c32fe0c6fa15d6e317d1e3cc7dfbf6bd3fb5a6e942014534af8473cd28). Refreshed only by governed upgrade commits; do not edit by hand. -->

## Purpose

`.github/contributor-kit.json` is the contributor kit as data: everything this product's station derived AGENTS.md, CONTRIBUTING.md and `scripts/contributor-check.sh` from, in one JSON document a teammate's tooling can read without parsing prose. It carries the kit's version and the policy digest it was derived from, so a tool can tell which kit a clone holds and whether it is current.

## Schema

The document is `kind: abp.contributor-kit` at schema `2.0.0`. Its fields:

- `schemaVersion`, `kind`, `kitVersion` — the document's schema, its kind and the monotonic kit version; the version is bumped only when what a teammate reads changes.
- `productRepositoryId`, `productRemoteUrl`, `targetBranch`, `publicationMode` — the public product repository, the remote teammates clone, the protected branch submissions target and how accepted work is published.
- `requirements` — each local dependency as `{ name, command, versionArgs, minimumVersion, install }`; `command` is a bare program name looked up on PATH.
- `host` — the supported `platforms` (lower-cased `uname -s`), `architectures` (normalised `uname -m`) and `minimumMemoryMiB` (0 declares no floor).
- `commands` — the `setup`, `localValidation` and `stationOnly` command lists the script runs or lists, exactly as the station's briefs publish them.
- `stationChecks` — the trusted checks the station re-runs on every submitted commit, each with `required` and `runnableLocally`.
- `docs`, `issueForms` — product-root-relative documents to read and the issue form types this repository ships.
- `requestFormat` — the request fields, request types, required fields per type, risk values, reserved section headings and labels the station's intake parses.
- `submission` — the `titleFormat` and `trailerFormat` every pull request carries.
- `policyDigest` — a digest of everything the kit was derived from; a change here is a policy upgrade.

## Examples

A tool checks the kit it is reading and the branch it must target:

```json
{
  "kind": "abp.contributor-kit",
  "schemaVersion": "2.0.0",
  "kitVersion": 2,
  "targetBranch": "master",
  "submission": {
    "trailerFormat": "Implements-Brief: brief-<issue>@v<version> base=<exact base commit>",
    "titleFormat": "[brief-<issue> v<version>] <summary>"
  }
}
```

## Consumers

- A teammate's AI coding agent or editor tooling, which recognises `kind` and reads the commands and submission formats instead of inferring them from prose.
- `scripts/contributor-check.sh`, which was generated from the same policy and must agree with this document line for line.
- The station that generated this kit: it compares every kit file with these bytes at each start and restores or upgrades them through a governed commit; it never edits them in place.

## Assumptions

- This file and the manifest are generated together and refreshed only by governed upgrade commits; a hand edit to either is restored by the next governed commit.
- Nothing here is private: every line was checked against the station's private facts before it could be published, and the digests it carries identify content without revealing it.
- Field meanings are stable within a schema version; a new schema version is announced by `schemaVersion`, never by silently changing a field.
