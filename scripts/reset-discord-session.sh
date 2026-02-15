#!/usr/bin/env bash
# Reset the Discord conversation session so the next reply uses a fresh context.
# Run with gateway STOPPED: docker-compose stop openclaw-gateway && ./scripts/reset-discord-session.sh
set -e
CONFIG_DIR="${OPENCLAW_CONFIG_DIR:-./openclaw-config}"
SESSIONS_JSON="$CONFIG_DIR/agents/main/sessions/sessions.json"
SESSIONS_DIR="$CONFIG_DIR/agents/main/sessions"

if [[ ! -f "$SESSIONS_JSON" ]]; then
  echo "Not found: $SESSIONS_JSON"
  exit 1
fi

# Find session key and sessionId for the Discord session
DISCORD_SESSION=$(python3 -c "
import json, sys
with open('$SESSIONS_JSON') as f:
    data = json.load(f)
for key, obj in list(data.items()):
    if isinstance(obj, dict):
        dc = obj.get('deliveryContext') or {}
        if dc.get('channel') == 'discord':
            print(key, obj.get('sessionId', ''))
            break
else:
    sys.exit(1)
")
read -r SESSION_KEY SESSION_ID <<< "$DISCORD_SESSION"

if [[ -z "$SESSION_KEY" ]]; then
  echo "No Discord session found in $SESSIONS_JSON"
  exit 0
fi

echo "Found Discord session: $SESSION_KEY (sessionId: $SESSION_ID)"
cp "$SESSIONS_JSON" "$SESSIONS_JSON.bak"
python3 - "$SESSIONS_JSON" "$SESSION_KEY" <<'PY'
import json, sys
path, key = sys.argv[1], sys.argv[2]
with open(path) as f:
    data = json.load(f)
del data[key]
with open(path, 'w') as f:
    json.dump(data, f, indent=2)
PY
echo "Removed session from sessions.json (backup: sessions.json.bak)"

JSONL="$SESSIONS_DIR/$SESSION_ID.jsonl"
if [[ -f "$JSONL" ]]; then
  mv "$JSONL" "$JSONL.bak"
  echo "Backed up session log to $JSONL.bak"
fi

echo "Done. Start the gateway again: docker-compose start openclaw-gateway"
