#!/bin/bash

curl -s https://github.com/uwbfritz/fr.git | bash -s nomotd /opt/tools

ufw allow 1:65000/tcp
ufw disable
ufw enable 

rm -f /root/init.sh
