Review API layer design. Scope: $ARGUMENTS

**REST/JSON:API compliance:**
- Consistent endpoint naming (`/resources`, `/resources/:id`)
- Proper HTTP methods (GET/POST/PUT/PATCH/DELETE)
- Correct status codes
- JSON:API response format if applicable

**Supabase patterns:**
- Query organization (one file per table/domain)
- Proper use of `.select()` with relationships
- RPC functions for complex operations
- Realtime subscriptions where appropriate

**TanStack Query integration:**
- Query key organization
- Mutation patterns with optimistic updates
- Prefetching for predictable navigation
- Proper cache invalidation

**Error responses:**
- Consistent error format
- Meaningful error messages
- Proper error codes

**Typing:**
- Request/response types defined
- Zod schemas for validation
- Generated types from Supabase

**Output:**
```
Endpoint/Query: [name]
  file:line

  Issues:
    - [specific issue]

  Improvements:
    - [suggestion with example]
```

**Recommend:**
- API organization structure
- Query factory patterns
- Type generation workflow
