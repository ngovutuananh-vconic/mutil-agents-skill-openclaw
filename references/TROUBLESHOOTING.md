# Troubleshooting — Multi-Agent OpenClaw

## Symptom: bot typing but no reply
Likely causes:
1. model timeout/failover
2. invalid model/provider mapping
3. send permission blocked

Checks:
- `openclaw channels status --probe`
- `openclaw status --all`
- gateway logs for timeout/failover

## Symptom: all bots reply at once in group
Cause:
- `requireMention=false` with open group

Fix:
- set `groups.*.requireMention=true`

## Symptom: bot mentioned but no response
Checks:
- token valid?
- correct `accountId` in bindings?
- group allow policy?
- bot actually in group?

## Symptom: model_not_found for memory embeddings
Cause:
- configured embedding model not available at endpoint

Fix paths:
1. switch to valid cloud embeddings endpoint/model
2. or move to local embeddings
3. reindex memory after model change

## Symptom: intermittent silence after restarts
Cause:
- aggressive watchdog/restart loops

Fix:
- disable unstable watchdog
- use cautious health policy
