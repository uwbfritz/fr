#!/bin/bash

source /opt/tools/.config

echo -e "$yellow Removing binaries, jobs, and folders.$red"

rm -rf /etc/tools
rm -rf $INST
rm -f /usr/local/bin/FireMotD
rm -rf /usr/share/firemotd
rm -f /etc/profile.d/motd-init.sh
rm -f /usr/bin/tools
crontab -l | grep -v '&& /usr/local/bin/FireMotD -S &>/dev/null'  | crontab -
echo "y"| gem uninstall lolcat
clear
echo -e "$yellow Uninstall: $red [COMPLETE] $clear"
sleep 4