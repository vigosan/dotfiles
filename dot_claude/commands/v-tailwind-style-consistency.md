Audit Tailwind CSS consistency. Scope: $ARGUMENTS

**Find inconsistencies:**
- Mixed styling approaches (CSS modules, inline styles, styled-components)
- Hardcoded colors instead of theme tokens (`#fff` vs `bg-white`)
- Hardcoded spacing instead of scale (`24px` vs `p-6`)
- Inconsistent responsive breakpoints usage
- Repeated class combinations that should be extracted
- `@apply` overuse (should be rare)

**Check design system alignment:**
- Colors not in `tailwind.config.ts`
- Custom spacing outside the scale
- Typography inconsistencies
- Border radius variations
- Shadow variations

**Component patterns:**
- Missing `cn()`/`clsx()` for conditional classes
- Overly long className strings (extract to variants)
- Inconsistent component variant naming

**Output:**
```
file:line
  Issue: [description]
  Current: [current code]
  Suggested: [fixed code]
```

**Recommend:**
- Tailwind config additions for design tokens
- Class extraction candidates
- Migration steps for non-Tailwind styles
