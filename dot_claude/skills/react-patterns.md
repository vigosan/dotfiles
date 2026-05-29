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

## References

- SRP in React (Khoshnevis): https://medium.com/@hossein.khoshnevis77/solid-in-react-js-single-responsibility-9fbfde0c2e49
- Composition pattern over props (Pomp): https://medium.com/@guilherme.pomp/creating-react-components-with-the-composition-pattern-f59c895f27bc
