#!/usr/bin/env bash
set -euo pipefail

echo "== Gateway status =="
openclaw gateway status || true

echo
echo "== Channel probe =="
openclaw channels status --probe || true

echo
echo "== Agent bindings =="
openclaw agents list --bindings || true

echo
echo "== Full status =="
openclaw status --all || true

echo
echo "Verification run complete."
