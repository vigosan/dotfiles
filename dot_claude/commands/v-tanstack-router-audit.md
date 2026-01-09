Audit TanStack Router implementation. Scope: $ARGUMENTS

**Route configuration:**
- Missing route types/validation
- Inconsistent path parameter naming
- Routes without proper error boundaries
- Missing `notFoundComponent` handlers
- Unused route definitions

**Data loading patterns:**
- Loaders not used for critical data (using useQuery instead)
- Missing `beforeLoad` for auth guards
- Heavy loaders blocking navigation
- Missing `staleTime` in loader queries
- No loading indicators during transitions

**Search params:**
- Untyped search params
- Missing validation/parsing
- State not synced with URL when it should be

**Code splitting:**
- Large route components not lazy loaded
- Missing `React.lazy` for route trees
- Prefetching not configured for predictable navigation

**Output:**
```
route: [path]
  file:line
  Issue: [description]
  Fix: [specific change]
```

**Recommend:**
- Route organization improvements
- Loader optimization strategies
- Type-safe search param patterns
