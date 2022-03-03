#!/bin/bash
# Dump user cron
# Purpose: 
# Version: 
# Author:
# Date:

# Include configuration and colors
source /opt/tools/.config

###################################################################################################
# Font colors: red, green, yellow, blue, purple, teal, white, grey                                #
# Font BG colors: bred, bgreen, byellow, bblue, bpurple, bteal, bwhite, bgrey                     #
# Formatting: clear, nc (same as clear), uline, bold, dim                                         #
# Variables: INST, BANNER, REPO                                                                   #
# Usage example: echo "$red $byellow Warning: $clear$yellow $REPO is unreachable. $clear"         #
# Note: Make sure to end with $clear or $nc                                                       #
###################################################################################################

# Clear terminal
clear

# Notice to user
echo -e "$yellow$bold\nTask: $green [STARTED] $clear"
echo ""

##############################
######## BEGIN SCRIPT ########
##############################

function instask {
    # INSERT CODE BELOW THIS LINE #
    mkdir -p /tmp/assets
    echo "User Cron Jobs" > /tmp/assets/allcron
    echo "-----------------" >> /tmp/assets/allcron
    echo " " >> /tmp/assets/allcron
    for user in $(cut -f1 -d: /etc/passwd); do echo " " && echo $user >> /tmp/assets/allcron && crontab -u $user -l >> /tmp/assets/allcron; done
    dialog --textbox /tmp/assets/allcron 40 200
    rm -rf /tmp/assets
}

##############################
########  END SCRIPT  ########
##############################

# Notify user of completion
instask
echo ""
echo -e "$yellow$bold\nTask: $green[COMPLETE]$clear"
# Provide user N seconds to view the output
sleep 3