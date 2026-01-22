# Development Rules

## Stack
Docker + Makefile + Vite + React 19 + TS + Tailwind v4 + Supabase + TanStack Query/Router + Vitest

## Mandatory Rules
- TDD: red-green-refactor (never skip red phase)
- Incremental commits: compile + tests pass
- Study 3 similar features before implementing
- Boring & obvious > clever
- Single responsibility, no premature abstractions
- Max 3 attempts when stuck → different angle

## Commit Requirements
- Compiles + all tests pass
- Tests for new functionality
- One functionality per commit
- Descriptive title only (no body, no feat:/fix:)

## Refactoring
NEVER add functionality while refactoring. Behavior-preserving only.

## Testing Selectors
data-testid (required) > semantic > text > CSS classes (never)

## Quality Gates
- [ ] Tests written & passing
- [ ] No linter warnings
- [ ] Self-documenting (ZERO comments)
- [ ] No TODOs without issue #s

## Critical
**NEVER**: `--no-verify`, disable tests, commit non-compiling, add code comments, CSS classes for testing
**ALWAYS**: Incremental commits, TDD, learn from existing code, prefer editing over creating
