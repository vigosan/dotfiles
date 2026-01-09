Audit TypeScript type safety. Scope: $ARGUMENTS

**Detect weak typing:**
- `any` usage (explicit and implicit)
- `as` type assertions (especially `as any`, `as unknown`)
- `@ts-ignore` / `@ts-expect-error` comments
- Missing return types on functions
- Untyped event handlers
- Generic `object` or `Function` types

**API/Data boundaries:**
- Missing Zod/Valibot validation for external data
- Supabase queries without proper typing
- TanStack Query without generic types
- Unvalidated user input

**Domain layer:**
- Entities using primitive types instead of value objects
- Missing branded types for IDs
- Optional properties that should be required

**React-specific:**
- Untyped props
- Missing generic types on hooks
- Event types using `any`

**Output:**
```
file:line
  Issue: [type weakness description]
  Current: [current code]
  Suggested: [properly typed version]
  Risk: [what bugs this could cause]
```

**Recommend:**
- Strict tsconfig settings to enable
- Validation library patterns
- Domain type improvements
