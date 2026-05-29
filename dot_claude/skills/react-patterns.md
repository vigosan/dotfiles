---
description: React 2026 patterns and architecture. Use when writing React components, hooks, data fetching, state management, or discussing React architecture. Triggers on: React, component, hook, useState, useEffect, useOptimistic, Server Components, TanStack Query, context, composition, props.
---

# React Patterns

## Stack
- **Testing**: Vitest + React Testing Library + user-event
- **Routing**: TanStack Router (type-safe, not React Router)
- **Data**: TanStack Query v5 (not raw fetch)
- **Styling**: Tailwind v4 + tailwind-merge
- **State**: Domain contexts + custom hooks (not Redux)

## React 2026 Patterns

### React Compiler
Auto-memoization. Remove manual useMemo/useCallback where compiler handles it.

### Server Components
Default for data fetching. `'use client'` only for interactivity.

### use() hook
Unwrap promises/context in render. Replaces some useEffect patterns.

### Server Actions
Form mutations without API routes. useActionState for pending/error states.

### Optimistic UI
useOptimistic for instant feedback. Assume success, update UI immediately.

### View Transitions
useViewTransition for route animations.

### useFormStatus
Pending states in forms without prop drilling.

## Component Principles

- Props >5 → consider composition
- Lines >150 → split
- Prop drilling >2 levels → context or composition
- Isolate side effects in useEffect (network, DOM, subscriptions only)
- Compute during render with useMemo, not effects

## Composition Patterns

**Composition first.** Prefer composing with `children`/slots over configuring a component through props. When a component grows boolean/config props or conditionally renders pieces, expose those pieces as composable children instead. Reach for prop-passing only when the parent must own the data.

- **Compound Components**: Share state via context
- **Context-Based**: Granular contexts + custom hooks
- **Render Props**: Inversion of control
- **Component Injection**: Polymorphic via props
- **Layered**: Tokens → Primitives → Shared → Product-specific

## Architecture

**Simple projects**:
```
src/
├── components/   # Reusable UI
├── contexts/     # Providers
├── hooks/        # Data fetching, logic
├── services/     # API clients
├── types/        # TypeScript
├── utils/        # Pure functions
├── pages/        # Page components
└── test/         # Test utils
```

**Complex projects**: Clean Architecture
- Domain (pure) → Application (use cases) → Services (adapters) → UI
- Ports & Adapters: interfaces in application, implementations in services
- Hooks as DI container

## Single Responsibility (SRP)

One component = one concern. Split fetching, state logic, and rendering into separate units.

```typescript
// ❌ Monolithic: fetch + filter + render
const Products = () => {
  const [products, setProducts] = useState([]);
  const [rate, setRate] = useState(1);
  useEffect(() => { fetch('/api/products')... }, []);
  return <>{products.filter(p => p.rating > rate).map(...)}</>;
};

// ✅ Separated concerns
const useProducts = () => { /* data fetching */ };
const useFilter = () => { /* filter state */ };
const ProductCard = ({ product }) => { /* presentation */ };
const RatingFilter = ({ value, onChange }) => { /* presentation */ };
```

Split signals: >1 reason to change, mixed I/O + UI, hard to name in one phrase.

## Dependency Inversion

```typescript
// ❌ Direct coupling
const UserList = () => {
  useEffect(() => { fetch('/api/users')... }, []);
};

// ✅ Abstraction via props/hooks
const UserList = ({ userRepository }: Props) => {
  const users = useUsers(userRepository);
};
```

Inject via props, context for global deps, repository pattern.

## Performance Patterns

### Granular Query Selectors
Avoid re-rendering a whole list when only one item changes. Use TanStack Query `select` to subscribe to the minimal slice of data each component needs.

```typescript
// ❌ Every consumer re-renders when any issue changes
const { data: issues } = useQuery({ queryKey: ['issues'], queryFn: fetchIssues });

// ✅ Re-renders only when this issue's title changes
const { data: title } = useQuery({
  queryKey: ['issues'],
  queryFn: fetchIssues,
  select: (issues) => issues.find((i) => i.id === id)?.title,
});
```

### Route-Level Code Splitting
Lazy-load route components and their data dependencies. With TanStack Router, combine `lazy()` with route loaders so each route chunk is fetched in parallel, not waterfall.

```typescript
// ✅ Each route is its own chunk; loader runs in parallel with component fetch
export const issuesRoute = createRoute({
  getParentRoute: () => rootRoute,
  path: '/issues',
  loader: () => queryClient.ensureQueryData(issuesQuery()),
  component: lazy(() => import('./IssuesPage')),
});
```

### Animation Constraints
Only animate composited properties — anything else triggers layout recalculation.

- **Safe**: `transform`, `opacity`
- **Never animate**: `width`, `height`, `margin`, `padding`, `top`, `left`
- Durations: appear ≤100ms, dismiss ≤150ms
- Asymmetric timing: elements appear instantly, fade out slowly

```typescript
// ✅ GPU-composited, no layout recalc
<motion.div
  initial={{ opacity: 0, transform: 'translateY(4px)' }}
  animate={{ opacity: 1, transform: 'translateY(0)' }}
  exit={{ opacity: 0 }}
  transition={{ duration: 0.1 }}
/>
```

## References

- SRP in React (Khoshnevis): https://medium.com/@hossein.khoshnevis77/solid-in-react-js-single-responsibility-9fbfde0c2e49
- Composition pattern over props (Pomp): https://medium.com/@guilherme.pomp/creating-react-components-with-the-composition-pattern-f59c895f27bc
