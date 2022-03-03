#!/bin/bash
# Add user
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
    trap script_trap_err ERR
    trap script_trap_exit EXIT
    # INSERT CODE BELOW THIS LINE #
    echo -e "$green Enter user name: $clear"
    read N_USER
    adduser $N_USER
    mkdir /home/$N_USER/.ssh
    touch /home/$N_USER/.ssh/authorized_keys
    chown -R $N_USER:$N_USER /home/$N_USER/.ssh
    chmod go-w /home/$N_USER /home/$N_USER/.ssh/authorized_keys
    mkdir -p /home/$N_USER/public_html
    chmod -R 755 /home/$N_USER/public_html
    chown -R $N_USER:$N_USER /home/$N_USER/public_html
    chmod 711 /home
    chmod 711 /home/$N_USER
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