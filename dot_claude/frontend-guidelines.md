# Frontend Development Guidelines

## React 2025 Patterns

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
