#!/bin/bash

if [ -f .env.local ]; then
  source .env.local
else
  echo ".env.local ファイルが見つかりません。"
  exit 1
fi

atlantis server \
  --gh-user=yiritani \
  --gh-token=$GITHUB_TOKEN \
  --gh-webhook-secret=$GITHUB_WEBHOOK_SECRET \
  --repo-allowlist=github.com/yiritani/next_go