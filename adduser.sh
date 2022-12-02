#!/bin/bash

# This script will prompt to input the user to be created.
# The home directory of the new user will also be created.

# If the user already exists, a message stating the user already exists will be displayed and the rest of the script will not be executed.

#####

# Prompt user to input the user to be created
echo Please type the user you want to create.

# Read the input and save to usertoadd variable
read usertoadd

# Check if the user already exists

if id -u $usertoadd &>/dev/null;

then 
	echo "User $usertoadd already exists!"

else
	sudo useradd -m $usertoadd
	#echo "user $usertoadd has been created and their home directory is $(cat /etc/passwd | grep $usertoadd | cut -d: -f6)"
	echo "user $usertoadd has been created and their home directory is $(getent passwd $usertoadd | cut -d: -f6)"

fi


