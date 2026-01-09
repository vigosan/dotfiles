Audit Clean Architecture compliance. Scope: $ARGUMENTS

**Verify layer structure:**
```
src/
├── domain/        # Entities, Value Objects, Domain Services
├── application/   # Use Cases, Ports (interfaces)
├── services/      # Adapters (Supabase, APIs, external)
└── ui/            # React components, hooks, pages
```

**Check dependency rules (inner layers cannot depend on outer):**
- Domain → no imports from application/services/ui
- Application → only imports from domain
- Services → imports from domain and application (implements ports)
- UI → can import from all layers

**Detect violations:**
- Direct Supabase imports in domain/application (should use ports)
- React imports in domain/application
- Business logic in UI components
- Domain entities with persistence concerns
- Use cases returning React components or UI state

**For each violation:**
```
file:line
  Layer: [current layer]
  Violation: imports from [violating layer]
  Import: [specific import]
  Fix: [how to resolve - extract to port/adapter]
```

**Output:**
- Dependency graph summary
- Violations by severity
- Refactoring steps to fix architecture
