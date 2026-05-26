---
description: Standardized Git commit messages following Flywire's Conventional Commits standard. Use when writing or reviewing commit messages, creating commits, or explaining commit conventions. Triggers on: commit, git commit, commit message, conventional commits, feat, fix, tech, SKIP_CD, HOTFIX, Victoria flags.
---

# Git Commit Messages — Flywire Standard

*Based on Conventional Commits v1.0.0 + Flywire Victoria pipeline flags compatibility.*

---

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

The scope is typically a JIRA ticket ID: `feat(INBD-1234): description`.

---

## Commit Types

| Type | When to use |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `tech` | Tech debt or refactor |
| `docs` | Documentation only |
| `test` | Adding or updating tests |
| `ci` | CI/CD configuration changes |
| `chore` | Maintenance, dependency bumps |
| `perf` | Performance improvements |
| `revert` | Reverts a previous commit |

---

## Victoria Pipeline Flags

Flags go **in the description field**, after the colon. Victoria scans the full message.

```
feat(INBD-1234): [SKIP_CD] add retry logic for failed transactions
chore: [FULL_PIPELINE][SKIP_MANUAL] deploy all environments
fix(INBD-4521): [HOTFIX] correct null check on payment processor response
```

---

## Examples

**Feature with JIRA ticket:**
```
feat(INBD-1234): add retry logic for failed transactions

Retries up to 3 times with exponential backoff.
Closes INBD-1234.
```

**Bug fix:**
```
fix(INBD-4521): correct null check on payment processor response
```

**Tech debt:**
```
tech(INBD-5678): extract payment gateway adapter
```

**CI change:**
```
ci: add commitlint stage to pipeline
```

---

## Rules

- **Description**: lowercase, imperative mood, no period at end
- **Scope**: optional — use JIRA ticket ID when available
- **Breaking change**: append `!` after type/scope — `feat(INBD-99)!: drop support for legacy API`
- **Body**: use to explain *why*, not *what* — the diff shows what
- **One logical change per commit** — never bundle unrelated changes

---

## GitLab Push Rules Regex

For repos enforcing the standard server-side:

```
^(feat|fix|tech|docs|test|ci|chore|perf|revert)(\(.+\))?(\!)?:\ .+
```

---

## When generating commit messages

1. Read staged diff to understand the change
2. Pick the most specific type — if `fix` and `tech` both apply, use the one that dominates intent
3. Include JIRA ticket in scope when it's in the branch name or recent context
4. Keep description under 72 characters
5. Add body only when the *why* is non-obvious from the diff
6. Never include "Generated with AI" or co-author lines
