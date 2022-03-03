#!/bin/bash
# Code Server

source /opt/tools/.config

baseip=$(hostname -I | cut -f1 -d' ')
baseport=8094
echo -e "$green Enter new password: $clear"
read basepassword

ufw allow $baseport/tcp

rm -f ~/.config/code-server/config.yaml
mkdir -p ~/.config/code-server

cat > ~/.config/code-server/config.yaml << EOF
bind-addr: ${baseip}:${baseport}
auth: password
password: ${basepassword}
cert: true
EOF

curl -fsSL https://code-server.dev/install.sh | sh

echo -e "$yellow Installation: $green[COMPLETE]$clear"
sleep 2