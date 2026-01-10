# Frontend Development Guidelines

## React 2025 Patterns

### Modern Hooks (React 19+)

#### useEffectEvent
Decouples effects from state dependencies - functions always access current state without stale closures.

```typescript
// ❌ Stale closure problem
useEffect(() => {
  const interval = setInterval(() => {
    console.log(userName); // Stale value!
  }, 1000);
  return () => clearInterval(interval);
}, []); // userName missing → stale, included → infinite reruns

// ✅ useEffectEvent solution
const onTick = useEffectEvent((tick: number) =>
  setMessage(`${userName} logged in for ${tick}s`) // Always current
);

useEffect(() => {
  let ticks = 0;
  const interval = setInterval(() => onTick(++ticks), 1000);
  return () => clearInterval(interval);
}, []); // No userName dependency needed
```

**When to use**: Access current state in effects without triggering re-runs (timers, subscriptions, event handlers inside effects).

#### useSyncExternalStore
For subscriptions to external stores (browser APIs, third-party state).

```typescript
const isOnline = useSyncExternalStore(
  (callback) => {
    window.addEventListener('online', callback);
    window.addEventListener('offline', callback);
    return () => {
      window.removeEventListener('online', callback);
      window.removeEventListener('offline', callback);
    };
  },
  () => navigator.onLine,
  () => true // SSR fallback
);
```

**When to use**: matchMedia, scroll position, external state libraries, any subscription-based external data.

#### useDeferredValue
Defers expensive computations to keep UI responsive.

```typescript
const [query, setQuery] = useState('');
const deferredQuery = useDeferredValue(query);

// Input stays snappy, filtering happens in background
const filtered = useMemo(
  () => items.filter(item => item.name.includes(deferredQuery)),
  [deferredQuery]
);
```

**Pairs with**: `startTransition` for deprioritizing expensive updates.

### Effect Best Practices
- **Isolate side effects**: Reserve `useEffect` for external operations only (network, DOM, subscriptions)
- **Compute during render**: Use `useMemo`/`useCallback` for derived state, not effects
- **SSR fallbacks**: Always provide deterministic values for window-dependent hooks
- **Custom hooks**: Extract domain logic into focused, reusable hooks

### Optimistic UI with useOptimistic
- Assume success, update UI immediately
- Combine with startTransition
- Pure update functions (no side effects)
- Visual feedback for optimistic items
- Handle failures with fallback

### Moving State Down
Push state to smallest component that needs it. Prevents unnecessary re-renders of siblings. State in parent → all children re-render; state in child → only that child re-renders. Use when state is independent and siblings don't need it.

### Dependency Inversion & Testing
- High-level ≠ depend on low-level (both depend on abstractions)
- Decouple data fetching from rendering
- Inject through props/context (avoid direct imports)
- Design for testability

### Component Composition

#### Patterns
- **Compound Components**: Share state via context
- **Context-Based**: Granular contexts + custom hooks
- **Render Props**: Inversion of control
- **Component Injection**: Polymorphic via props
- **Layered Architecture**: Tokens → Primitives → Shared → Product-specific → Specialized

#### Guidelines
- Single responsibility
- Inversion of control
- Context for coordination
- Hooks for reusability
- Flexible APIs with sensible defaults

## Preferred Stack

### Testing
- **Runner**: Vitest (not Jest)
- **Library**: React Testing Library + @testing-library/jest-dom
- **Interactions**: @testing-library/user-event
- **Utils**: Custom renderWithProviders wrapper
- **Mocking**: vi.mock()

### Styling
- **Framework**: Tailwind CSS v4+
- **Plugin**: @tailwindcss/vite
- **Utilities**: tailwind-merge

### Data & Routing
- **Data**: TanStack Query v5 (not fetch)
- **Router**: TanStack Router (not React Router) - type-safe
- **State**: Domain-specific contexts + custom hooks

### Architecture

**Simple projects**:
```
src/
├── components/  # Reusable UI
├── contexts/    # Providers
├── hooks/       # Data fetching, logic
├── services/    # API clients
├── types/       # TypeScript
├── utils/       # Pure functions
├── pages/       # Page components
└── test/        # Test utils
```

**Complex projects**: Use [Clean Architecture](frontend-clean-architecture-guidelines.md) with Domain/Application/Services/UI layers for better testability and maintainability.

## Architecture Principles

### Dependency Inversion (DIP)
Decouple components from implementations - depend on abstractions.

```typescript
// ❌ Direct coupling
const UserList = () => {
  useEffect(() => { fetch('/api/users')... }, []);
  // ...
};

// ✅ Abstraction via props/hooks
const UserList = ({ userRepository }: { userRepository: UserRepository }) => {
  const users = useUsers(userRepository);
  // ...
};
```

**Patterns**: Inject via props, context for global deps, repository pattern

### Component Composition
- **Single Responsibility**: One concern per component
- **Open-Closed**: Extend via composition (children, render props), not modification
- **Interface Segregation**: Minimal, focused props

```typescript
// Extensible via composition
const Card = ({ children }) => <div className="card">{children}</div>;

// Specific variants
const UserCard = () => (
  <Card>
    <Avatar />
    <UserInfo />
  </Card>
);
```

**For full SOLID principles and layered architecture**, see [Clean Architecture](frontend-clean-architecture-guidelines.md).
