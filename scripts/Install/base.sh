#!/bin/bash
# Base installation 
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
echo -e "$yellow$bold\nInstallation: $green [STARTED] $clear"
echo ""

##############################
######## BEGIN SCRIPT ########
##############################

function instask {
    trap script_trap_err ERR
    trap script_trap_exit EXIT
    # INSERT CODE BELOW THIS LINE #
    apt-get install -y wget git nano screen net-tools at ncdu unzip pdsh iftop bat tmux lnav fonts-powerline goaccess
    yes | cp /opt/tools/assets/.bashrc ~/.bashrc
    yes | cp /opt/tools/assets/.tmux.conf ~/.tmux.conf
    cd /tmp
    source ~/.bashrc
    cd ~/
}

##############################
########  END SCRIPT  ########
##############################

# Notify user of completion
instask
echo ""
echo -e "$yellow$bold\nInstallation: $green[COMPLETE]$clear"
# Provide user N seconds to view the output
sleep 3