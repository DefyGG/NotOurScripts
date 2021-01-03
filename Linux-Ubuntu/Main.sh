#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
apt-get install rkhunter tree debsums libpam-cracklib chkrootkit clamav lynis 

echo "Starting misc. things now"
./Misc.sh

./Users.sh
echo "Users have been fixed"

./PAM.sh
echo "PAM files script has been ran"

./RemoveBadSoftwares.sh
echo "Bad softwares have been removed"


./RemoveBadFiles.sh
echo "Bad files have been removed"



apt-get autoremove
echo "Done"
clear
