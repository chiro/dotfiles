---
name: simplify
description: Review and simplify code from first principles when the user asks to remove unnecessary complexity, challenge an implementation's assumptions, or simplify a change or codebase. Does not run as a routine step after every coding task.
---

# Simplify

Interrogate whether the implementation is the simplest way to achieve the user's
actual goal. Prefer deleting over simplifying, simplifying over optimizing, and
optimizing over automating. No change is a valid outcome.

## Establish intent and scope

Use the user's request, requirements, callers, and relevant tests to determine
what the code must accomplish and which behavior must remain intact. Distinguish
documented requirements from assumptions embedded in the implementation.

Stay within the requested scope. For “simplify this change,” start with the
current diff and inspect surrounding code as needed to understand it. Do not
expand a local cleanup into a repository-wide redesign. Honor review-only
requests; otherwise apply justified simplifications.

## Challenge the implementation

Ask:

- What is unnecessary, overly complicated, or based on a weak assumption?
- What can be deleted entirely without losing required behavior?
- Once those pieces are gone, what can be made simpler?

Look for abstractions without a useful purpose, duplicated state, redundant
transformations, and machinery for requirements that do not exist. Treat these
as candidates to investigate, not automatic reasons to edit.

Before deleting a candidate, inspect its callers, dependencies, and purpose.
Account for external consumers and dynamic use when relevant; absence of local
references alone does not prove something is unused. Compatibility paths and
error handling may serve real requirements. Fewer lines alone do not establish
an improvement.

## Apply and verify

Make focused changes that reduce concepts, indirection, or maintenance burden
while preserving required behavior. Do not add a replacement framework or
automation unless the task actually needs it. Resolve uncertainty about a
requirement before making a change that depends on dropping it.

Run checks appropriate to the affected behavior. Add or update tests when they
provide meaningful confidence, rather than merely reflecting the new structure.

Report what was removed or simplified, why it was justified, and how it was
verified, including any remaining uncertainty. If the implementation is already
appropriate, leave it alone and explain that conclusion briefly.

Inspired by [George Pickett's first-principles review prompt](https://x.com/georgepickett/status/2095979879137460640).
