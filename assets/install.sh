#!/bin/bash

green='\e[32m' 
blue='\e[34m'
red='\e[31m'
yellow='\e[33m'
clear='\e[0m'

if [ "$2" == "" ]
then
INST=/opt/tools
else
INST=$2
fi

mkdir -p $INST
apt-get install -y ruby wget curl bc sysstat jq moreutils perl multitail tree joe htop git figlet dialog
cd $INST
git clone https://git.tacoma.uw.edu/bfritz/fr.git .
ln -s $INST/tools /usr/bin/tools
echo "sed -i 's~START=.*~START=$INST~' $INST/tools" | bash
echo "sed -i 's~INST=.*~INST=$INST~' $INST/.config" | bash
find $INST/scripts/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
find $INST/assets/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
find $INST/assets/uninstall/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g

cd .lolcat/lolcat-master/bin
gem install lolcat
yes | cp ./opt/tools/.lolcat/lolcat-master/bin/lolcat /usr/bin/lolcat
cd $INST
clear
echo -e "$yellow DBX tools installer: $green [SUCCESS] $clear"
echo -e " "
echo -e "$yellow Use the $red tools $yellow command to invoke the administration menu. $clear "
