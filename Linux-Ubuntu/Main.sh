#!/bin/bash

if [ "$EUID" -ne 0 ] ;
	then echo "Run as Root"
	exit
  

./PAM.sh
echo "PAM files script has been ran"

./RemoveBadSoftwares.sh
echo "Bad softwares have been removed"

./Users.sh
echo "Users have been fixed"

./RemoveBadFiles.sh
echo "Bad files have been removed"


echo "Starting misc. things now"
./Misc.sh


apt-get autoremove
echo "Done"
clear
