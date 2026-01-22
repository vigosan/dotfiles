---
description: Testing patterns with Vitest and React Testing Library. Use when writing tests, discussing testing strategy, or reviewing test code. Triggers on: test, spec, Vitest, Testing Library, mock, assert, describe, it, expect, coverage, TDD.
---

# Testing Patterns

## Stack
- **Runner**: Vitest (not Jest)
- **Library**: React Testing Library + @testing-library/jest-dom
- **Interactions**: @testing-library/user-event
- **Mocking**: vi.mock()

## TDD Cycle

1. **Red**: Write failing test for desired behavior
2. **Green**: Write minimal code to pass (no more)
3. **Refactor**: Improve design while tests stay green

### Discipline
- Never skip red phase (proves test catches failure)
- Keep green phase minimal
- Refactor only with green bar
- If stuck, delete and restart with smaller test

## Element Selection Priority

```typescript
// ✅ Best: data-testid (required on testable elements)
screen.getByTestId('submit-button')

// ✅ OK: Semantic queries
screen.getByRole('button', { name: 'Submit' })

// ⚠️ Avoid: Text content (brittle)
screen.getByText('Submit')

// ❌ Never: CSS classes or container.querySelector
```

## React Testing Library

### User Events
```typescript
import userEvent from '@testing-library/user-event'

const user = userEvent.setup()
await user.click(button)
await user.type(input, 'text')
```

### Async Handling
```typescript
// Wait for element
await screen.findByTestId('result')

// Wait for condition
await waitFor(() => {
  expect(screen.getByTestId('status')).toHaveTextContent('Done')
})
```

### Custom Render
```typescript
function renderWithProviders(ui: React.ReactElement) {
  const queryClient = new QueryClient({
    defaultOptions: { queries: { retry: false } }
  })

  return render(
    <QueryClientProvider client={queryClient}>
      {ui}
    </QueryClientProvider>
  )
}
```

## TanStack Query Testing

```typescript
// Proper setup
const queryClient = new QueryClient({
  defaultOptions: {
    queries: { retry: false, gcTime: 0 }
  }
})

// Cleanup between tests
afterEach(() => {
  queryClient.clear()
})

// Mock server responses preferred over mocking hooks
```

## Test Quality

### Good Tests
- Test behavior not implementation
- One assertion per test preferred
- Clear descriptive names
- Deterministic (no flaky tests)
- Proper cleanup between tests

### Anti-patterns
- Redundant tests covering same behavior
- Brittle tests (implementation details, timing)
- Poor assertions (too broad or specific)
- Missing async handling
- Tests without meaningful descriptions

## Advanced Techniques

### Characterization Tests
Capture existing behavior before refactoring.

### Mutation Testing
Verify test quality by introducing mutations.

### Coverage Gaps
- Components without `.test.tsx`
- Custom hooks without tests
- Domain entities and value objects
- Service layer adapters
- Utility functions

## Architecture Testing

### Domain Layer
```typescript
// Pure functions - easy to test
expect(addProduct(cart, product).products).toHaveLength(2)
```

### Application Layer
```typescript
// Mock ports
const mockPayment = { tryPay: vi.fn().mockResolvedValue(true) }
await orderProducts(user, cart, { payment: mockPayment })
```

### UI Layer
```typescript
// Mock use cases
vi.mock('../../application/orderProducts')
render(<Buy />)
```
