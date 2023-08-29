#!/bin/sh

# Run xray cloudflared ttyd
./ttyd -c ${WEB_USERNAME}:${WEB_PASSWORD} -p 2222 -d 0 bash & 
./cloudflared tunnel --edge-ip-version auto --loglevel panic --protocol auto run --token ${ARGO_AUTH} &
./xray -config /app/config.json
