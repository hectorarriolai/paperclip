#!/bin/bash
# Paperclip server start script (used by launchd)
cd /Users/Shared/hillflare/paperclip/server

export PATH="/opt/homebrew/opt/node@22/bin:/opt/homebrew/bin:$PATH"

if [[ -f /Users/Shared/hillflare/paperclip/PAUSE_SERVICE ]]; then
  echo "Paperclip service paused by host maintenance: /Users/Shared/hillflare/paperclip/PAUSE_SERVICE exists"
  exec /usr/bin/tail -f /dev/null
fi

exec npx cross-env \
  PORT=3100 \
  PAPERCLIP_MIGRATION_PROMPT=never \
  HEARTBEAT_SCHEDULER_ENABLED=false \
  PAPERCLIP_DEPLOYMENT_MODE=authenticated \
  PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
  PAPERCLIP_AUTH_BASE_URL_MODE=auto \
  "BETTER_AUTH_TRUSTED_ORIGINS=http://localhost:3100,http://127.0.0.1:3100,http://100.100.80.8:3100,https://hfs-mac-mini.tail425490.ts.net:3100" \
  "PAPERCLIP_ALLOWED_ATTACHMENT_TYPES=image/*,application/pdf,text/*,application/json,application/vnd.openxmlformats-officedocument.*,application/vnd.ms-excel,application/msword,application/vnd.ms-powerpoint,application/vnd.oasis.opendocument.*,video/mp4,video/quicktime,audio/mpeg,audio/mp4,image/svg+xml,application/zip" \
  HOST=0.0.0.0 \
  npx tsx src/index.ts
