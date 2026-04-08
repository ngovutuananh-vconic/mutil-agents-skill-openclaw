# Operating modes for multi-agent deployments

## Mode A — Mention-only group (recommended)
Use when multiple bots share one group/server and you want only the addressed bot to reply.

## Mode B — Account-bound DM routing
Use when each bot/account should map deterministically to one agent.

## Mode C — Open collaborative room
Use only when overlap is acceptable and users expect multiple agents to contribute.

## Rule of thumb
- High-risk/noisy environments: mention-only or strict account routing
- Customer-facing bots: strict account routing
- Internal experiments: collaborative mode is acceptable
