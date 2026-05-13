# Development Rules

## Stack
Docker + Makefile + Vite + React 19 + TS + Tailwind v4 + Supabase + TanStack Query/Router + Vitest

## Before Coding
- State assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If something is unclear, stop. Name what's confusing. Ask.
- Read exports, immediate callers, and shared utilities before adding code.
- Study 3 similar features before implementing.

## Simplicity
- Boring & obvious > clever.
- No features beyond what was asked.
- No abstractions for single-use code.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

## Surgical Changes
- Don't improve adjacent code, comments, or formatting.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.
- Remove imports/variables/functions that YOUR changes made unused.
- Every changed line must trace directly to the request.

## Execution
- Transform tasks into verifiable goals before starting.
- For multi-step tasks, state a brief plan with success criteria per step.
- Max 3 attempts when stuck → different angle.
- Checkpoint after every significant step: what was done, what's verified, what's left.
- If you lose track, stop and restate before continuing.

## Commit Requirements
- Compiles + all tests pass.
- Tests for new functionality.
- One functionality per commit.
- Descriptive title only (no body, no feat:/fix:).

## Refactoring
NEVER add functionality while refactoring. Behavior-preserving only.

## Testing
- TDD: red-green-refactor (never skip red phase).
- Tests must encode WHY behavior matters, not just WHAT it does.
- Selectors: data-testid (required) > semantic > text > CSS classes (never).

## Quality Gates
- [ ] Tests written & passing
- [ ] No linter warnings
- [ ] Self-documenting (ZERO comments)
- [ ] No TODOs without issue #s

## Conventions
- Surface conflicts between patterns — don't average them. Pick one, explain why, flag the other.
- Conformance > taste inside the codebase. Surface harmful conventions, don't fork silently.

## Fail Loud
- "Completed" is wrong if anything was skipped silently.
- "Tests pass" is wrong if any were skipped.
- Default to surfacing uncertainty, not hiding it.

## Critical
**NEVER**: `--no-verify`, disable tests, commit non-compiling, add code comments, CSS classes for testing
**ALWAYS**: Incremental commits, TDD, learn from existing code, prefer editing over creating
