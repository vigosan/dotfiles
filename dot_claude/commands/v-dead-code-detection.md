Scan for dead code in the codebase. Scope: $ARGUMENTS

**Find:**
- Unused exports (functions, components, types, constants)
- Unused imports
- Unreachable code paths
- Commented-out code blocks
- Unused CSS classes (if not using Tailwind)
- Unused TanStack Query hooks
- Stale Supabase queries/mutations
- Unused route definitions

**Exclude from analysis:**
- Public API exports
- Test utilities
- Type-only exports used for declaration

**Output:**
```
file:line - [type] description
  Safe to remove: yes/verify
```

**Recommend:**
- Files that can be entirely deleted
- Exports to remove from barrel files
- Steps to verify before removal
