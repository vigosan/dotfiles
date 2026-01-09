Analyze all changes (staged, unstaged, and untracked) and create separate commits grouped by functionality.

**Steps:**
1. Run `git status` and `git diff` to analyze all changes
2. Group changes logically by:
   - Feature additions
   - Bug fixes
   - Refactoring
   - Configuration changes
   - Test updates
   - Style/UI changes
3. For each group, execute:
   - `git add <files>`
   - `git commit -m "<message>"`
4. Use imperative mood, max 50 chars, no prefixes (feat:, fix:, etc.)

**Before committing, consider running:**
- `/v-dead-code-detection` if files were deleted/refactored
- `/v-test-audit` if new code was added
- `make test` to verify nothing broke

**Output after each commit:**
```
Committed: "<message>"
  Files: <list>
```

**Ask for confirmation before executing commits.**
