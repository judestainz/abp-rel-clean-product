# Asking the station for a change

Open the Request form, fill in What do you want?, and choose a request type or Let the station suggest.

Plain words need a station with drafting enabled. The station drafts a request for you to review; reply with changes in plain words or confirm the exact version with `/abp confirm v1` (use the version shown). Planning starts only after confirmation.

A complete structured request goes directly to RECEIVED. Copy [the AI sample](REQUEST_SAMPLE.md), replace its example answers and keep the headings exactly as shown. Use one of: plan-and-implement, plan-only, review-and-integrate.

## Fields

- **Request type**: Which request type is this: plan-and-implement, plan-only or review-and-integrate?
- **Objective**: What outcome should this change achieve?
- **Expected behavior**: How should the product behave once this is done?
- **Acceptance criteria**: Which observable acceptance criteria decide that it is done?
- **Exclusions**: What is explicitly out of scope?
- **Relevant context**: Which existing behavior, issue or contract is relevant?
- **Risk**: Is the risk low, medium or high?
- **Existing task**: Which approved task does this refer to?
- **Pull request**: Which pull request in this repository should be reviewed? Give its number, for example #12.
- **Task or brief**: Which task or brief, and which version, does the pull request implement?

## Required fields by request type

- plan-and-implement: Request type, Objective, Expected behavior, Acceptance criteria, Risk.
- plan-only: Request type, Objective, Expected behavior, Acceptance criteria, Risk.
- review-and-integrate: Request type, Pull request.

Accepted Risk values: low, medium, high.

## Station-supplied validation

Describe observable product outcomes as acceptance criteria. The station supplies validation. Do not state tests, check commands, budgets or reviewers in a request; a policy section is refused with INTAKE_POLICY_OVERRIDE. In plain words, such demands receive a policy note and cannot override the station.

The approved trusted checks are:

- `test`

Reserved section headings (never add these to the sample):

- approval
- approved
- approver
- approvers
- assignee
- assignees
- budget
- budgets
- labels
- label
- permissions
- permission
- policy
- priority
- review
- reviewer
- reviewers
- review policy
- validation
- validators
- allowed paths
- protected paths
- sessions
- spend
