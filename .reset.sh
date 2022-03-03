#!/bin/bash

INST=$1
find $INST/scripts/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
find $INST/assets/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
find $INST/assets/motd/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
find $INST/assets/uninstall/ -type f -print0 | xargs -0 sed -i s~/opt/tools~$INST~g
echo "sed -i 's~START=.*~START=$INST~' $INST/tools" | bash
echo "sed -i 's~INST=.*~INST=$INST~' $INST/.config" | bash
