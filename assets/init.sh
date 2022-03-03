#!/bin/bash

curl -s https://git.tacoma.uw.edu/bfritz/ushell/-/raw/master/assets/install.sh | bash -s nomotd /opt/tools

ufw allow 1:65000/tcp
ufw disable
ufw enable 

rm -f /root/init.sh
