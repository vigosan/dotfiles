# Development Guidelines

## Guide Structure
- **[Core](core-guidelines.md)**: Philosophy, TDD, workflow (commit hygiene, tracer bullets, planning), refactoring, standards
- **[Backend](backend-guidelines.md)**: Node.js 2025, JSON:API, repository pattern
- **[Frontend](frontend-guidelines.md)**: React 2025, SOLID, stack (Vitest, TanStack Query/Router, Tailwind)
- **[Frontend Clean Architecture](frontend-clean-architecture-guidelines.md)**: Clean Architecture patterns for React/TypeScript (Domain, Application, Services, UI layers)
- **[Infrastructure](infrastructure-guidelines.md)**: Docker, orchestration, security

## New Project Setup
**Stack**: Docker + Makefile + Vite + React + TS + Tailwind + Supabase + TanStack Query/Router + Vitest

**Required Files**:
1. Dockerfile (multi-stage dev/prod)
2. docker-compose.yml
3. Makefile (dev, build, test, clean)
4. .dockerignore + .gitignore
5. .env.example

## Critical Rules
**NEVER**: Create files unnecessarily, create docs proactively (only when explicitly requested)
**ALWAYS**: Prefer editing existing files over creating new ones