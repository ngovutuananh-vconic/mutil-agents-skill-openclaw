# Deployment Checklist — Multi-Agent OpenClaw

## Pre-flight
- [ ] OpenClaw version confirmed
- [ ] Backup current config
- [ ] Agent IDs finalized
- [ ] Workspace paths finalized
- [ ] Model refs validated
- [ ] Channel tokens collected
- [ ] Secret handling plan decided (env/secret ref/private config)

## Config
- [ ] `agents.list[]` created
- [ ] unique `workspace` per agent
- [ ] unique `agentDir` per agent
- [ ] channel accounts created
- [ ] routing complete (`bindings[]` or current account mapping style)
- [ ] `defaultAccount` set for multi-account channels
- [ ] examples merged safely (no blind overwrite of live config)

## Workspace scaffold
- [ ] persona files created
- [ ] `memory/` exists for every agent
- [ ] seed memory files exist

## Restart + probe
- [ ] `openclaw gateway restart`
- [ ] `openclaw channels status --probe`
- [ ] `openclaw agents list --bindings`

## Functional tests
- [ ] DM each bot passes
- [ ] group mention behavior matches policy
- [ ] one fallback-path test passes
- [ ] no critical errors in logs
- [ ] memory status is ready for each agent

## Handover
- [ ] save project logsheet
- [ ] update master log
- [ ] update memory notes
