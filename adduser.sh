#!/bin/bash

# This script is expected to work properly only on Red Hat-based Linux distributions.
# It will prompt to input the user to be created.
# The home directory of the new user will also be created.

# If the user already exists, a message stating the user already exists will be displayed and the rest of the script will not be executed.

#####

if
    [ $# -ge 1 ] && id "$@" &>/dev/null
then
    for usertoadd in "$@"; do
	#echo "The arg count is $#"
        echo "User(s) $usertoadd already exists!"
        id $usertoadd
        exit
    done
    exit
elif
    [ $# -ge 1 ]
then
    for usertoadd in "$@"; do
	#echo "The arg count is $#"
        sudo useradd -m "$usertoadd"
        echo "user $usertoadd has been created and their home directory is $(getent passwd "$usertoadd" | cut -d: -f6)"
    done
    exit
fi

# Prompt user to input the user to be created
echo Please type the user you want to create.

# Read the input and save to usertoadd variable
read -r usertoadd

# Check if the user already exists

if id "$usertoadd" &>/dev/null; then
    echo "User $usertoadd already exists!"

else
    sudo useradd -m "$usertoadd"

    if [ $? = 0 ]; then
        echo "user $usertoadd has been created and their home directory is $(getent passwd "$usertoadd" | cut -d: -f6)"
    else
        exit
    fi

fi
