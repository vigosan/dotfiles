Review React component quality. Target: $ARGUMENTS

**Component structure:**
- Size (flag >150 lines for splitting)
- Single responsibility adherence
- Props count (flag >5 props - consider composition)
- Mixing concerns (data fetching + presentation + logic)

**Patterns:**
- Correct hook usage (rules of hooks)
- Proper key usage in lists
- Missing memoization where needed
- Controlled vs uncontrolled consistency

**Composition:**
- Prop drilling (>2 levels - use context or composition)
- Component composition opportunities
- Missing compound component patterns
- Reusable vs specific components

**Naming and organization:**
- Clear, descriptive component names
- File organization matching component hierarchy
- Consistent naming conventions

**Tailwind/Styling:**
- Inline styles that should use Tailwind
- Class organization (layout → spacing → typography → visual)
- Responsive design patterns

**Output:**
```
ComponentName (file:line)
  Lines: X | Props: Y | Hooks: Z

  Issues:
    - [issue with severity]

  Suggestions:
    - [specific improvement]
```

**Recommend:**
- Splitting candidates
- Extraction opportunities
- Pattern improvements
