#!/bin/sh

PORT=${PORT:-8080}
UUID=${UUID:-"a2a4b855-a710-4b35-bdfb-1511beb4fe71"}
WSPATH=${WSPATH:-"/vless"}

# 动态写入 Xray 配置文件
cat <<EOF > /etc/xray/config.json
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "level": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$WSPATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

echo "Starting Xray on port $PORT with UUID $UUID and WS Path $WSPATH..."
exec /usr/local/bin/xray run -c /etc/xray/config.json
