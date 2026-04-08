# Operating modes for multi-agent deployments

## Mode A — Mention-only group (recommended)
- `requireMention = true`
- behavior: only mentioned bot answers
- best for control/noise reduction

## Mode B — Open discussion group
- `requireMention = false`
- behavior: multiple bots may respond
- best for brainstorming, but noisy

## Mode C — Coordinator-fronted (high reliability)
- one public bot in channel
- internal specialist agents behind coordinator
- best when consistency and predictability matter
