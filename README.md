# OpenClaw Multi-Agent Kit

Portable skill package to deploy **multi-agent OpenClaw** systems on one machine.

> Goal: copy this folder to another OpenClaw host, enable the skill, scaffold isolated workspaces, merge safe config snippets, and verify routing cleanly.

---

## What this kit solves

- 1 Gateway + many agents
- each agent = own workspace + SOUL + model + memory/session boundary
- many Telegram/Discord bots in one gateway
- deterministic routing by bindings / account mapping
- stable rollout checklist + troubleshooting

---

## Folder structure

```text
openclaw-multi-agent-kit/
├─ SKILL.md
├─ README.md
├─ _meta.json
├─ examples/
│  ├─ openclaw.multi-agent.telegram.example.json5
│  └─ openclaw.multi-agent.discord.example.json5
├─ assets/
│  └─ templates/
│     ├─ AGENTS.md
│     ├─ USER.md
│     ├─ TOOLS.md
│     ├─ SOUL.coordinator.md
│     ├─ SOUL.specialist.md
│     └─ HEARTBEAT.md
├─ references/
│  ├─ CHECKLIST.md
│  ├─ TROUBLESHOOTING.md
│  └─ OPERATING_MODES.md
└─ scripts/
   ├─ scaffold-workspaces.sh
   └─ verify-multi-agent.sh
```

---

## Installation

### Option A — copy folder directly

```bash
mkdir -p ~/.openclaw/workspace/skills
cp -R openclaw-multi-agent-kit ~/.openclaw/workspace/skills/
```

### Option B — git clone into workspace skills

```bash
git clone <YOUR_GITHUB_REPO_URL> ~/.openclaw/workspace/skills/openclaw-multi-agent-kit
```

No extra runtime dependency required for this kit itself.

---

## Quick start

### 1) Scaffold workspaces first

```bash
bash scripts/scaffold-workspaces.sh \
  ~/.openclaw/workspace/projects/du-an-4bot-phat-trien-du-an/coordinator \
  ~/.openclaw/workspace/projects/du-an-4bot-phat-trien-du-an/quy-hoach \
  ~/.openclaw/workspace/projects/du-an-4bot-phat-trien-du-an/phap-ly \
  ~/.openclaw/workspace/projects/du-an-4bot-phat-trien-du-an/hanh-chinh
```

This script now creates:
- core persona files (`AGENTS.md`, `USER.md`, `TOOLS.md`, `HEARTBEAT.md`, `SOUL.md`)
- `memory/`
- seed files: `memory/MEMORY.md`, `memory/SEED.md`, `memory/YYYY-MM-DD.md`

### 2) Apply config safely

Use the files under `examples/` as **reference snippets**.

> ⚠️ **Do not overwrite** your live `~/.openclaw/openclaw.json` with `cp` in production.
> Merge only the needed blocks into your real config.

Recommended merge targets:
1. `agents.list[]`
2. `bindings[]` or channel-to-agent account routing
3. `channels.<provider>.accounts.*`
4. agent model refs / aliases

### 3) Fill secrets/tokens securely

- Telegram bot tokens: `channels.telegram.accounts.*.botToken`
- Discord bot tokens: `channels.discord.accounts.*.token`
- Prefer environment variables / secret refs / private config injection
- Do not commit real tokens into git

### 4) Restart + probe

```bash
bash scripts/verify-multi-agent.sh
```

### 5) Functional test

- DM each bot once
- mention each bot in group / server where relevant
- verify correct route, persona, and reply behavior

---

## Core principles

### 1) One agent = one brain boundary
An agent should own:
- unique `workspace`
- unique `agentDir`
- unique model strategy
- unique persona files
- unique memory/session boundary

Never reuse `agentDir` between agents.

### 2) 4 mandatory blocks
Multi-agent only works correctly when all 4 are present:
1. `agents.list[]`
2. `channels.<channel>.accounts`
3. routing (`bindings[]` or equivalent account mapping in current config style)
4. restart + probe

### 3) Group mention policy
If you need only mentioned bot to reply:
- configure mention-only behavior for the channel/group policy

If you need open discussion among bots:
- allow open group replies
- expect occasional overlap/noise

---

## Model strategy guidance

Suggested pattern:
- Coordinator agent: balanced/reliable model
- Specialist agents: domain-strong models
- Always configure at least one fallback when the host/provider mix allows it

If bot shows typing but no reply:
- check model timeout/failover first
- then token/account mapping
- then channel send permissions

---

## Production checklist

Use `references/CHECKLIST.md` before go-live.

Minimum pass criteria:
- every account probes `works`
- every bot DM test passes
- group mention behavior matches policy
- no repeated timeout/errors in logs
- one fallback-path test passes

---

## Troubleshooting entry points

1. `openclaw gateway status`
2. `openclaw channels status --probe`
3. `openclaw status --all`
4. read gateway logs

See `references/TROUBLESHOOTING.md`.

---

## Reuse for other OpenClaw hosts

To replicate on another host:
1. copy this skill folder
2. scaffold isolated workspaces
3. merge the example config blocks safely
4. fill channel tokens and model refs
5. restart + probe + test

This kit is designed to be repo-friendly and host-portable.
