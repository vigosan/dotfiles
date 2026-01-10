# Development Guidelines

## Stack 2026
Docker + Makefile + Vite + React 19 + TS + Tailwind v4 + Supabase + TanStack Query/Router/Start + Vitest

## Core Rules

### Philosophy
- TDD by default (red-green-refactor)
- Incremental commits (compile + tests pass)
- Study existing code before implementing
- Boring & obvious > clever
- Single responsibility, no premature abstractions

### Workflow
1. `git status` → clean slate required
2. Study patterns → find 3 similar features
3. Test first (red) → minimal impl (green) → refactor
4. Commit with clear message (imperative, no prefixes)
5. Max 3 attempts when stuck → document failures, try different angle

### Commit Requirements
- Compiles + all tests pass
- Tests for new functionality
- One functionality per commit
- Descriptive title only (no body, no feat:/fix:)

### Refactoring
NEVER add functionality while refactoring. Behavior-preserving only. Test after each tiny change.

## Frontend

### Preferences
- **Testing**: Vitest + React Testing Library + user-event
- **Selectors**: data-testid (required) > semantic > text > CSS classes (never)
- **Routing**: TanStack Router (type-safe, not React Router)
- **Data**: TanStack Query v5 (not raw fetch)
- **Styling**: Tailwind v4 + tailwind-merge
- **State**: Domain contexts + custom hooks (not Redux)

### React 2026 Patterns
- **React Compiler**: Auto-memoization, remove manual useMemo/useCallback where compiler handles it
- **Server Components**: Default for data fetching, 'use client' only for interactivity
- **use() hook**: Unwrap promises/context in render (replaces some useEffect patterns)
- **Server Actions**: Form mutations without API routes, useActionState for pending/error states
- **Optimistic UI**: useOptimistic for instant feedback
- **View Transitions**: useViewTransition for route animations
- **useFormStatus**: Pending states in forms without prop drilling

### Component Principles
- Props >5 → consider composition
- Lines >150 → split
- Prop drilling >2 levels → context or composition
- Isolate side effects in useEffect (network, DOM, subscriptions only)
- Compute during render with useMemo, not effects

### Architecture (when needed)
Simple: `components/ contexts/ hooks/ services/ types/ utils/ pages/`
Complex: Clean Architecture → Domain (pure) → Application (use cases) → Services (adapters) → UI

## Backend
- ESM + `node:` prefix for built-ins
- JSON:API responses: `{data, meta}` or `{errors: [{status, title, detail}]}`
- Repository pattern with interface-first design

## Infrastructure
All services containerized. Multi-stage Dockerfiles. Makefile: dev/build/test/clean.

## Quality Gates
- [ ] Tests written & passing
- [ ] No linter warnings
- [ ] Self-documenting (ZERO comments)
- [ ] No TODOs without issue #s
- [ ] data-testid for testable elements

## Critical Rules
**NEVER**: `--no-verify`, disable tests, commit non-compiling, add code comments, CSS classes for testing, create files unnecessarily
**ALWAYS**: Incremental commits, TDD, learn from existing code, prefer editing over creating, stop after 3 failures
