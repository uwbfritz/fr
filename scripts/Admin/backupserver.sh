#!/bin/bash
# Backup Server (Migrate)
# Purpose: Prep server for migration to another host


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
####### USER VARIABLES #######
##############################

# Migrate user accounts
MACCT=1

# Migrate /etc
METC=1

# Migrate /root
MROOT=1

# Migrate webroot
MWEB=0

# Migrate MySQL filebase
MSQL=0

# Migrate MySQL databases
MSQLDB=0

# Migrate cron
MCRON=1

##############################
####### END VARIABLES ########
##############################

##############################
######## BEGIN SCRIPT ########
##############################

function instask {
    trap script_trap_err ERR
    trap script_trap_exit EXIT
    # INSERT CODE BELOW THIS LINE #
    if [[ $MACCT == 1 ]]; then
        echo -e "$green\nBacking up user accounts... $clear"
        # Create output directory
        mkdir /move
        # Setup UID filter limit
        export UGIDLIMIT=500
        # Copy /etc/passwd accounts, filtering out system accounts
        awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/passwd > /move/passwd.mig
        # Copy /etc/group
        awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534)' /etc/group > /move/group.mig
        # Copy /etc/shadow
        awk -v LIMIT=$UGIDLIMIT -F: '($3>=LIMIT) && ($3!=65534) {print $1}' /etc/passwd | tee - |egrep -f - /etc/shadow > /move/shadow.mig
        # Copy /etc/gshadow (may remove)
        cp /etc/gshadow /move/gshadow.mig
        # Backup /home and mail dirs
        tar -zcvpf /move/home.tar.gz /home
        tar -zcvpf /move/mail.tar.gz /var/spool/mail
    fi

    if [[ $METC == 1 ]]; then
        # Backup /etc/ directory
        tar -pczf /move/etc.tar.gz /etc
    fi

    if [[ $MROOT == 1 ]]; then
        # Backup /root/ directory
        tar -pczf /move/root.tar.gz /root
    fi

    if [[ $MWEB == 1 ]]; then
        # Backup /var/www directory
        tar -pczf /move/web.tar.gz /var/www
    fi
    
    if [[ $MSQL == 1 ]]; then
        # Backup /var/lib/mysql directory
        tar -pczf /move/mysql.tar.gz /var/lib/mysql
    fi

    if [[ $MSQLDB == 1 ]]; then
        # Backup all non-system MySQL dbs
        echo -e "$green Enter user name: $clear"
        read MYSQL_USER
        echo -e "$green Enter password: $clear"
        read MYSQL_PWD
        databases=`MYSQL_PWD=$MYSQL_PWD mysql --user=$MYSQL_USER -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`
        rm -rf /move/mysql/
        mkdir -p /move/mysql/
        cd /move/mysql/
        for db in $databases; do
            if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != _* ]] && [[ "$db" != "mysql" ]] && [[ "$db" != "sys" ]]; then
                        MYSQL_PWD=$MYSQL_PWD mysqldump --user=$MYSQL_USER $db > $db.sql
                        echo -e "$yellow DATABASE: $clear$db$red[backup_complete]$clear"
                        echo " "
            fi
        done
    fi

    if [[ $MSQL == 1 ]]; then
        # Backup cron
        for user in $(cut -f1 -d: /etc/passwd); do echo " " && echo $user >> /move/allcrontabs.bak && crontab -u $user -l >> /move/allcrontabs.bak; done
    fi

    tar pczf /migrate.tar.gz /move
    rm -rf /move
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