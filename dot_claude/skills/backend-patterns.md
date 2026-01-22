---
description: Node.js backend patterns, JSON:API, and repository pattern. Use when writing backend code, APIs, Node.js services, or discussing backend architecture. Triggers on: backend, API, Node.js, endpoint, repository, JSON:API, service, adapter, Express, server.
---

# Backend Patterns

## Node.js Patterns

### Core Principles
- ESM as primary module system
- `node:` prefix for built-ins (prevents conflicts)
- Top-level await for init
- async/await with comprehensive error handling
- `Promise.all()` for parallel operations

### Performance & Tooling
- Worker Threads for CPU-intensive tasks
- Web Streams for processing
- `--watch` mode for auto-reload
- `--env-file` for environment management
- Built-in test runner
- Dynamic imports for conditional loading

### Error Handling
- Structured error classes with metadata (timestamp, context, status)
- Fail fast with descriptive messages
- Include debugging context
- Handle at appropriate level
- Never silently swallow

## JSON:API Standard

### Structure
```typescript
// Success
{ data: { id, type, attributes }, meta?: {} }

// Collection
{ data: [{ id, type, attributes }], meta: { count, page, totalPages } }

// Error
{ errors: [{ status, title, detail, source: { pointer } }] }
```

### Implementation
```typescript
export class JsonApiBuilder {
  static success<T>(data: T, meta?: Record<string, any>) {
    return { data, ...(meta && { meta }) };
  }

  static error(status: number, title: string, detail?: string) {
    return { errors: [{ status: status.toString(), title, detail }] };
  }

  static resource(id: string, type: string, attributes: Record<string, any>) {
    return { id, type, attributes };
  }
}
```

### Guidelines
- Consistent response structure (all endpoints)
- Resource-oriented (type, id, attributes)
- Kebab-case types ("espresso-shot", "user-profile")
- String IDs always
- Include metadata (pagination, timing, context)
- Source pointers for field-specific errors

## Repository Pattern

### Benefits
- Independent development
- Rapid iterations
- Scenario simulation
- Predictable testing

### Guidelines
- Interface-first design (contracts before implementation)
- Consistent methods across implementations
- Mock parity with real API (including errors)
- Full TypeScript coverage
- Single responsibility (one repo per domain/entity)

### Testing Strategy
- Unit tests with mocks (predictable data)
- Integration tests (real API)
- Error scenarios (failures, edge cases)
- Performance testing (timeouts, slow responses)

## Infrastructure

### Docker Requirements
- All services containerized with own Dockerfile
- Multi-stage builds for production
- Non-root users, minimal base images
- docker-compose.yml for orchestration
- Health check endpoints
- Graceful shutdown with proper signal handling

### Makefile Integration
- `make dev` - local development
- `make build` - production build
- `make test` - run tests in containers
- `make clean` - cleanup
