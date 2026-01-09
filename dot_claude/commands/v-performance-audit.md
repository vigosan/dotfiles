Review React performance issues. Scope: $ARGUMENTS

**Detect:**
- Unnecessary re-renders (missing memo, unstable references)
- Heavy computations without `useMemo`
- Inline object/array/function props causing re-renders
- Large component trees without code splitting
- Missing `React.lazy` for route-based splitting
- Effects running too often (missing/wrong deps)
- State lifted too high causing cascade re-renders

**TanStack specific:**
- Queries without `select` for derived data
- Missing `structuralSharing` consideration
- Router loaders not used for critical data

**Tailwind specific:**
- Overly complex className computations
- Missing `clsx`/`cn` for conditional classes

**Output:**
- Components with issues (file:line)
- Specific optimization recommendations
- Before/after code examples
- Impact estimation (high/medium/low)
