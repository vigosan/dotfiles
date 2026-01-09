Audit Docker configuration. Scope: $ARGUMENTS

**Dockerfile:**
- Missing multi-stage builds (dev/prod)
- Large base images (use alpine/slim variants)
- Missing `.dockerignore` entries
- Root user instead of non-root
- Missing health checks
- Secrets in build args or ENV
- Layer ordering not optimized for caching
- Missing `--no-cache` for package managers

**docker-compose.yml:**
- Missing resource limits (memory, CPU)
- Hardcoded credentials (should use secrets/env)
- Missing restart policies
- Volumes not properly configured
- Network isolation issues
- Missing depends_on with condition

**Development experience:**
- Hot reload not working
- Missing volume mounts for node_modules
- Slow builds due to layer cache invalidation

**Security:**
- Exposed ports that shouldn't be
- Missing read-only filesystems where possible
- Privileged containers without need

**Output:**
```
file:line
  Issue: [description]
  Impact: [security/performance/dx]
  Fix: [specific change]
```

**Recommend:**
- Optimized Dockerfile structure
- Compose file improvements
- Makefile targets to add
