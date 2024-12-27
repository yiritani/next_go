#!/bin/bash

if [ -f .env.local ]; then
  source .env.local
else
  echo ".env.local ファイルが見つかりません。"
  exit 1
fi

ngrok http --url=$ATLANTIS_DOMAIN 4141