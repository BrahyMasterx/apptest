#!/bin/sh

# Run xray cloudflared ttyd
./ttyd -c ${WEB_USERNAME}:${WEB_PASSWORD} -p 2222 -d 0 bash & 
./cloudflared tunnel --edge-ip-version 4 --loglevel panic --protocol http2 run --token ${ARGO_AUTH} &
./xray -config /app/config.json
