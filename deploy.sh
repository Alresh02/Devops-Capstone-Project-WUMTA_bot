#!/bin/bash
# Usage: ./deploy.sh <EC2_PUBLIC_IP> <path-to-key.pem>
EC2_IP="$1"
KEY="$2"
if [ -z "$EC2_IP" ] || [ -z "$KEY" ]; then
  echo "Usage: ./deploy.sh <EC2_PUBLIC_IP> <path-to-key.pem>"
  exit 1
fi

docker pull reshars/uptime-monitor:latest || true
ssh -o StrictHostKeyChecking=no -i "$KEY" ubuntu@"$EC2_IP" \
  "docker pull reshars/uptime-monitor:latest || true &&
   docker stop uptime-monitor || true &&
   docker rm uptime-monitor || true &&
   docker run -d --name uptime-monitor \
     -e TELEGRAM_BOT_TOKEN=\"$TELEGRAM_BOT_TOKEN\" \
     -e TELEGRAM_CHAT_ID=\"$TELEGRAM_CHAT_ID\" \
     -e CHECK_INTERVAL=300 \
     reshars/uptime-monitor:latest"
