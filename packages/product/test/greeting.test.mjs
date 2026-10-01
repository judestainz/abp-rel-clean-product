/**
 * Purpose: Prove the dummy greeting module's one behaviour.
 * Learning objectives: See the smallest product test the station's trusted validation and the product CI both run.
 * Responsibilities: Assert the exact greeting text.
 * Key concepts: node:test with strict assertions; no fixtures and no I/O.
 * Algorithms: One equality assertion.
 * Assumptions: Runs under Node.js 22 or newer.
 * Inputs and outputs: No inputs; reports pass or fail through node:test.
 * Error handling: A mismatch fails the test with node's assertion diff.
 * Complexity: O(1).
 * Usage: `npm test` from the product root.
 * Related files: ../greeting.mjs, ../../../package.json, ../../../.github/workflows/ci.yml.
 */
import { test } from "node:test";
import assert from "node:assert/strict";
import { greeting } from "../greeting.mjs";

test("greeting names the person", () => {
  assert.equal(greeting("team"), "Hello, team!");
});
