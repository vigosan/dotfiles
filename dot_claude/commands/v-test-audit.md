Audit test coverage and quality using Vitest. Scope: $ARGUMENTS

## Coverage Analysis

**Find untested code:**
- React components without `.test.tsx` or `.spec.tsx`
- Custom hooks without test coverage
- Domain layer entities and value objects
- Application layer use cases
- Service layer adapters (Supabase, API clients)
- Utility functions

**For each untested file:**
```
path/to/file.ts (0% coverage)
  Priority: high/medium/low
  Key tests needed:
    - [happy path test]
    - [edge case test]
    - [error state test]
```

## Quality Analysis

**Review existing tests for:**
- Redundant tests covering same behavior
- Missing edge cases and error paths
- Brittle tests (implementation details, timing issues)
- Poor assertions (too broad or too specific)
- Missing async handling (`waitFor`, `findBy*`)
- Improper mock cleanup between tests
- Tests without meaningful descriptions

**Testing Library best practices:**
- Prefer `getByRole` over `getByTestId`
- Avoid `container.querySelector`
- Use `userEvent` over `fireEvent`
- Proper `act()` usage for state updates

**TanStack Query test patterns:**
- Proper QueryClientProvider wrapping
- Query cache cleanup between tests
- Mock server responses vs mocking hooks directly

## Output

```
COVERAGE GAPS:
  file:line - [priority] [suggested tests]

QUALITY ISSUES:
  file:line - [issue] [fix]

RECOMMENDED ACTIONS:
  1. [prioritized action]
```
