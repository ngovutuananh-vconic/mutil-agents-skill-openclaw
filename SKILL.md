---
name: openclaw-multi-agent-kit
description: |
  End-to-end playbook for designing and deploying generic OpenClaw multi-agent systems
  on one machine: multiple agents, isolated workspaces, separate personas/models,
  multiple Telegram/Discord accounts, deterministic routing, and production troubleshooting.
  Use this skill when the user wants a reusable multi-agent baseline for any domain,
  not a project-specific bot stack.
---

# OpenClaw Multi-Agent Kit

Use this skill when user intent is any of:
- "1 máy chạy nhiều bot"
- "multi agent"
- "mỗi bot 1 soul/model"
- "map nhiều Telegram/Discord bot vào nhiều agent"
- "tách workspace cho từng bot"
- "vì sao bot cùng trả lời / không trả lời / miss tin"
- "muốn làm bộ khung multi-agent dùng lại cho host khác"

## Deliverable
Create a **generic, reusable multi-agent baseline** with:
1. separate agent definitions
2. separate workspaces + persona files
3. separate memory roots per agent
4. channel accounts per bot/account
5. deterministic routing / bindings
6. verification + troubleshooting notes

## Default architecture (recommended)
- one gateway
- one primary agent
- zero or more specialist agents
- one workspace per agent
- one `agentDir` per agent
- separate channel accounts when persona isolation is required
- mention-only or account-specific routing when collisions are risky

## Important design rules
1. **Do not bake in domain-specific assumptions** unless the user explicitly asks.
2. **Do not hardcode project-specific workspace names** in final examples.
3. **Do not tell users to overwrite live config blindly**; always merge safely.
4. **Every workspace should be memory-ready** (`memory/`, `MEMORY.md`, seed files).
5. **Every agent should have unique `workspace` and unique `agentDir`**.

## Workflow

### 1) Clarify deployment shape
Ask / infer only what is needed:
- Which channels? (Telegram / Discord / mixed)
- How many agents?
- Is routing by account, binding, or mention policy?
- Should each agent have a separate persona/model?
- Is this for one host only or a portable reusable kit?

### 2) Build reusable structure
Use or create:
- `assets/templates/` for generic workspace starter files
- `examples/` for safe config snippets
- `scripts/scaffold-workspaces.sh` to initialize workspaces
- `scripts/verify-multi-agent.sh` to verify health after rollout

### 3) Keep examples generic
Use neutral examples like:
- `main`
- `agent-a`
- `agent-b`
- `support`
- `research`
- `ops`

Avoid project-locked examples unless the user explicitly wants a project-specific kit.

### 4) Safe config guidance
When writing docs/examples:
- say **merge snippet into config**
- do **not** say `cp example -> ~/.openclaw/openclaw.json`
- remind user to keep tokens in env / secret refs / private config

### 5) Verification
After setup, verify:
- gateway status
- channel probe status
- account-to-agent mapping
- DM test
- group mention behavior
- memory readiness for each agent

## Read these references when needed
- `references/CHECKLIST.md` — go-live checklist
- `references/TROUBLESHOOTING.md` — common multi-agent failures
- `references/OPERATING_MODES.md` — routing modes and tradeoffs

## Use these scripts
- `scripts/scaffold-workspaces.sh` — create generic agent workspaces + memory seeds
- `scripts/verify-multi-agent.sh` — verify gateway/channel/agent status

## Output standard
When delivering or revising this skill, ensure:
- generic wording
- no client-specific paths by default
- no project-specific bot names unless explicitly requested
- reusable examples
- production-safe guidance
