/**
 * Purpose: Return a friendly greeting for a name — the dummy product module of the ABP team-collaboration demonstration.
 * Learning objectives: See the smallest possible product module a station can build, validate, review and publish.
 * Responsibilities: Format one greeting string; nothing else.
 * Key concepts: A pure function with no I/O, so its tests are deterministic.
 * Algorithms: String interpolation.
 * Assumptions: The caller passes a string; this demo module does not validate or trim input.
 * Inputs and outputs: Takes a name string; returns "Hello, <name>!".
 * Error handling: None needed; any value is interpolated as JavaScript converts it to a string.
 * Complexity: O(n) in the length of the name.
 * Usage: `import { greeting } from "./greeting.mjs"; greeting("team")` returns `"Hello, team!"`.
 * Related files: ./test/greeting.test.mjs, ../../README.md.
 */

/**
 * Greet a person by name.
 *
 * @param {string} name who to greet
 * @returns {string} the greeting, "Hello, <name>!"
 */
export function greeting(name) {
  return `Hello, ${name}!`;
}
