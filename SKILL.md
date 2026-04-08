---
name: openclaw-multi-agent-kit
description: |
  End-to-end playbook for designing and deploying OpenClaw multi-agent systems
  (single gateway, multiple agents, multiple channel accounts, isolated workspaces,
  bindings, model mapping, and production troubleshooting).
  Use this skill when the user asks to set up multiple bots/agents on one machine,
  split personas by channel/account, or make multi-agent routing stable and reusable.
---

# OpenClaw Multi-Agent Kit

Use this skill when user intent is any of:
- "1 máy chạy nhiều bot"
- "multi agent"
- "mỗi bot 1 soul/model"
- "map nhiều Telegram/Discord bot vào nhiều agent"
- "tách workspace cho từng bot"
- "vì sao bot cùng trả lời / không trả lời / miss tin"

## Outcome
Deliver a **working multi-agent baseline** with:
1. separate agent definitions
2. separate workspaces + SOULs
3. channel accounts per bot
4. deterministic bindings
5. health checks + troubleshooting notes

## Default architecture (recommended)
**One Gateway + Many Agents + Many Channel Accounts**

Do NOT recommend running many gateway processes unless user explicitly asks.

## Mandatory checklist (always apply)
1. Confirm agent list (`agents.list[]`) exists and each agent has unique `id`.
2. Confirm each agent has unique `workspace` + unique `agentDir`.
3. Confirm each bot/account exists under `channels.<channel>.accounts`.
4. Confirm route exists in `bindings[]` for each account (`accountId -> agentId`).
5. Confirm `defaultAccount` is set when multiple accounts exist.
6. Restart gateway and run probes.
7. Verify each bot with at least one real message.

## Fast implementation flow
1. Copy the template config from `examples/`.
2. Fill tokens/credentials in `channels.<channel>.accounts.*`.
3. Create or sync each workspace from `assets/templates/`.
4. Set per-agent models.
5. Add bindings.
6. `openclaw gateway restart`
7. `openclaw channels status --probe`
8. Test DM + group behavior.

## Group behavior policy (important)
If users want "@ai thì bot đó mới trả lời":
- set `groups.*.requireMention = true`

If users want "không @ thì bot nào cũng có thể trả lời":
- set `groups.*.requireMention = false`
- warn that responses may overlap

## Telegram reality check
Multiple bots can coexist in one group, but bot-to-bot deep conversation may be unstable/noisy.
Recommend one coordinator-facing bot + internal agent orchestration when reliability matters.

## Validate after deployment
Run:
```bash
openclaw gateway status
openclaw channels status --probe
openclaw status --all
```

If bots show typing then no reply:
- inspect gateway logs for model timeout/failover
- verify account token, binding, and model/provider availability
- verify channel send permissions

## References
- Full guide: `README.md`
- Config examples: `examples/`
- Workspace templates: `assets/templates/`
- Troubleshooting: `references/TROUBLESHOOTING.md`
