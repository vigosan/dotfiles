Audit error handling patterns. Scope: $ARGUMENTS

**Missing error handling:**
- Async operations without try/catch or .catch()
- Supabase queries ignoring error responses
- TanStack Query without `onError` or error boundaries
- Promises without rejection handling
- Event handlers that can throw

**Poor error handling:**
- Silent failures (catch with no action)
- Generic error messages hiding root cause
- Console.log instead of proper error reporting
- Re-throwing without context

**User experience:**
- Missing error boundaries for component trees
- No fallback UI for failed queries
- Missing toast/notification for operation failures
- Form errors not displayed to user

**Domain errors:**
- Using exceptions for expected failures (should use Result type)
- Missing custom error classes
- Error messages mixed with business logic

**Output:**
```
file:line
  Issue: [description]
  Risk: [what happens when it fails]
  Fix: [proper error handling pattern]
```

**Recommend:**
- Error boundary placement
- Result/Either pattern for domain
- Error reporting service setup
- User-friendly error message patterns
