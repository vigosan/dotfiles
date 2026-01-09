Find opportunities for custom hooks. Scope: $ARGUMENTS

**Identify repeated patterns:**
- Same `useState` + `useEffect` combination in multiple components
- Duplicated TanStack Query configurations
- Repeated form handling logic
- Common event listener patterns
- Duplicated localStorage/sessionStorage access
- Repeated Supabase subscription setups

**For each opportunity:**
```
Pattern found in:
  - file1:line
  - file2:line
  - file3:line

Suggested hook:
  Name: useXxx
  Parameters: [...]
  Returns: [...]

Example implementation:
  [code snippet]
```

**Placement following Clean Architecture:**
- UI hooks → `src/ui/hooks/`
- Application hooks → `src/application/hooks/`
- Infrastructure hooks → `src/services/hooks/`
