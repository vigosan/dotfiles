Audit accessibility (a11y) issues. Scope: $ARGUMENTS

**Check WCAG 2.1 AA compliance:**
- Missing or incorrect ARIA attributes
- Images without meaningful alt text
- Form inputs without labels
- Missing focus indicators (check Tailwind focus: classes)
- Color contrast issues
- Keyboard navigation gaps
- Missing skip links
- Improper heading hierarchy

**React-specific:**
- Missing `aria-live` for dynamic content
- Focus management after route changes (TanStack Router)
- Modal/dialog focus trapping
- Loading state announcements

**Tailwind-specific:**
- Missing `sr-only` for icon-only buttons
- Focus ring visibility (`focus:ring-*`, `focus-visible:*`)

**Output:**
- Issues grouped by severity (critical/serious/moderate/minor)
- File:line references
- WCAG criterion violated
- Fix recommendation with code example
