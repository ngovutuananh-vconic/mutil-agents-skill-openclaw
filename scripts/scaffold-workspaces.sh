#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <workspace1> [workspace2 ...]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="${SCRIPT_DIR}/../assets/templates"
TODAY="$(date +%F)"

for ws in "$@"; do
  echo "Scaffolding: $ws"
  mkdir -p "$ws" "$ws/memory"

  # Core persona files (idempotent)
  [[ -f "$ws/AGENTS.md" ]] || cp "$TEMPLATE_DIR/AGENTS.md" "$ws/AGENTS.md"
  [[ -f "$ws/USER.md" ]] || cp "$TEMPLATE_DIR/USER.md" "$ws/USER.md"
  [[ -f "$ws/TOOLS.md" ]] || cp "$TEMPLATE_DIR/TOOLS.md" "$ws/TOOLS.md"
  [[ -f "$ws/HEARTBEAT.md" ]] || cp "$TEMPLATE_DIR/HEARTBEAT.md" "$ws/HEARTBEAT.md"

  # SOUL defaults to specialist template when no explicit role provided
  if [[ ! -f "$ws/SOUL.md" ]]; then
    cp "$TEMPLATE_DIR/SOUL.specialist.md" "$ws/SOUL.md"
  fi

  # Memory seed files (important for memory index readiness)
  if [[ ! -f "$ws/memory/MEMORY.md" ]]; then
    cat > "$ws/memory/MEMORY.md" <<EOF
# MEMORY.md

Long-term memory for this agent workspace.

## Initial seed
- Workspace initialized: ${TODAY}
- Keep durable decisions, runbooks, and stable preferences here.
EOF
  fi

  if [[ ! -f "$ws/memory/SEED.md" ]]; then
    cat > "$ws/memory/SEED.md" <<EOF
# SEED.md

Starter notes for this agent.
- Add project scope
- Add operating constraints
- Add escalation rules
EOF
  fi

  if [[ ! -f "$ws/memory/${TODAY}.md" ]]; then
    cat > "$ws/memory/${TODAY}.md" <<EOF
# ${TODAY}

- Workspace scaffold created.
EOF
  fi

done

echo "Done."
