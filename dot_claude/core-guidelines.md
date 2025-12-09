# Core Development Guidelines

## Philosophy
- Incremental progress over big bangs (compile + tests pass)
- Study existing code before implementing
- Pragmatic over dogmatic
- Boring & obvious > clever code
- Single responsibility, no premature abstractions
- **TDD by default**: Tests enable verification, safe refactoring, and confident changes

## Test-Driven Development (TDD)

### Why TDD
- **Verification over guessing**: Without independent verification, implementation is guessing
- **Safe refactoring**: Tests enable aggressive refactoring and safe code deletion
- **Design feedback**: Red-green-refactor reveals design issues early
- **AI collaboration**: TDD makes AI-assisted development more effective (agents need verification)

### TDD Cycle (Red-Green-Refactor)
1. **Red**: Write failing test for desired behavior
2. **Green**: Write minimal code to pass (no more)
3. **Refactor**: Improve design while tests stay green
4. Repeat

### When to Apply TDD
- **Always**: New features, bug fixes (write test that reproduces bug first)
- **Exception**: Exploratory spikes (throw away code, then TDD the real implementation)

### Advanced Testing Techniques
Consider when appropriate:
- Characterization tests (capture existing behavior before refactoring)
- Mutation testing (verify test quality)
- Image/snapshot regression testing (UI changes)

### TDD Discipline
- Never skip the red phase (proves test catches failure)
- Keep green phase minimal (resist adding "just one more thing")
- Refactor only with green bar
- If stuck, delete and restart with smaller test

## Workflow

### 1. Commit Hygiene (MANDATORY)
Before ANY new work:
1. `git status` → check uncommitted changes
2. Group & commit by functionality: `git add . && git commit -m "description"`
3. Clean working directory required
4. One functionality per commit

### 2. Tracer Bullets
- Build thinnest vertical slice first
- Test core concept early
- Small, complete increments per commit
- Refactor continuously vs big rewrites

### 3. Planning
Use `IMPLEMENTATION_PLAN.md` with checkboxes, 3-5 stages:
```markdown
## Stage N: [Name]
**Goal**: [Deliverable]
**Status**: [ ] Not Started | [X] Complete
- [X] Task done
- [ ] Task pending
```
Check plan before starting. Use `/reset` between stages.

### 4. Implementation Flow
1. Git status → clean slate
2. Study existing patterns
3. Test first (red)
4. Minimal implementation (green)
5. Refactor with tests passing
6. Commit with clear message

### 5. Refactoring Rules
**NEVER add functionality while refactoring**:
- Behavior-preserving only
- One thing at a time (refactor OR feature)
- No new parameters/fields/methods
- Same interface for callers
- Test after each tiny change

Red flags: new parameters, return values, "while I'm here..." thinking

Good: extract method, rename, move code, simplify conditionals, remove duplication

### 6. When Stuck (Max 3 Attempts)
1. Document failures + errors
2. Research 2-3 alternatives
3. Question abstraction level
4. Try different angle (library/pattern/simplify)

## Technical Standards

### Architecture
- Composition > inheritance (DI)
- Interfaces > singletons (testability)
- Explicit > implicit (clear flow)
- Test-driven (never disable tests)

### Commit Requirements
- Compiles successfully
- All tests pass
- Tests for new functionality
- Follows formatting/linting
- Descriptive title only (no body, no feat:/fix: prefixes)

### Error Handling
- Fail fast with descriptive messages
- Include debugging context
- Handle at appropriate level
- Never silently swallow

## Decision Framework
Choose by: Testability → Readability → Consistency → Simplicity → Reversibility

## Project Integration
- Find 3 similar features
- Match existing patterns/conventions
- Use same libraries/utilities
- Don't introduce new tools without justification

## Quality Gates

### Definition of Done
- [ ] Tests written & passing
- [ ] Follows conventions
- [ ] No linter warnings
- [ ] Clear commit messages
- [ ] Matches plan
- [ ] No TODOs without issue #s
- [ ] Self-documenting (ZERO comments)

### Testing
- Test behavior not implementation
- One assertion per test preferred
- Clear descriptive names
- Deterministic tests
- **Element selection**: data-testid (required) > semantic > text > CSS classes (never)

## Critical Rules
**NEVER**: `--no-verify`, disable tests, commit non-compiling code, add code comments, use CSS classes for testing
**ALWAYS**: Incremental commits, update plan, learn from existing code, stop after 3 failures