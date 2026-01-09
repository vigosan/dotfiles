Analyze data fetching in this React project using TanStack Query. Focus on: $ARGUMENTS

**Scan for:**
- Inefficient patterns: N+1 requests, over-fetching, redundant queries
- Missing TanStack Query features: staleTime, gcTime, placeholderData, select
- Queries that should use `useQueries` for batching
- Missing `prefetchQuery` for predictable navigation
- Supabase queries without proper RLS consideration

**Recommend:**
- Query key structure following `[entity, action, params]` convention
- Proper invalidation strategies with `queryClient.invalidateQueries`
- Optimistic updates for mutations with `onMutate`/`onError`/`onSettled`
- Suspense boundaries with `useSuspenseQuery` where appropriate
- Infinite queries for paginated Supabase data

**Output:**
- List of problematic queries with file:line references
- Refactoring examples using TanStack Query best practices
- Priority ranking (critical/high/medium/low)
