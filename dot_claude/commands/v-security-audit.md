Audit security vulnerabilities. Scope: $ARGUMENTS

## General Security

**Injection attacks:**
- SQL injection in raw queries
- XSS through dangerouslySetInnerHTML
- Command injection in any exec calls
- Template injection

**Authentication/Authorization:**
- Missing auth checks on protected routes
- Insecure token storage (localStorage vs httpOnly cookies)
- Missing CSRF protection
- Exposed API keys in client code
- Hardcoded credentials

**Data exposure:**
- Sensitive data in console.log
- PII in error messages
- Secrets in git history
- Excessive data in API responses

**Dependencies:**
- Known vulnerabilities (check npm audit)
- Outdated packages with security fixes
- Unused dependencies that increase attack surface

**Client-side:**
- Missing Content Security Policy
- Open redirects
- Clickjacking vulnerabilities
- Missing input sanitization

## Supabase Security

**Row Level Security (RLS):**
- Tables without RLS enabled
- Overly permissive policies (e.g., `true` for all operations)
- Missing policies for CRUD operations
- Policies not using `auth.uid()` properly
- Policies that could leak data across users

**Supabase client-side:**
- Exposed service role key (should only use anon key)
- Sensitive operations on client (should be in Edge Functions)
- Missing input validation before Supabase calls
- SQL injection vectors in `.rpc()` calls

**Supabase auth patterns:**
- Missing auth state checks before protected operations
- Token refresh handling
- Session persistence configuration

**File storage:**
- Public buckets with sensitive data
- Missing bucket policies
- Large file uploads without size limits

## Output

```
[CRITICAL/HIGH/MEDIUM/LOW] file:line or table:policy
  Vulnerability: [type]
  Description: [what's wrong]
  Risk: [how it could be exploited]
  Fix: [remediation]
```

## Recommendations
- Security headers to add
- RLS policy templates for common patterns
- Edge Function extraction candidates
- Auth flow improvements
- Dependency update strategy
