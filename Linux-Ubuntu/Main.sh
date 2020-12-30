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

ufw enable
sysctl -n net.ipv4.tcp_syncookies
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
echo "nospoof on" | sudo tee -a /etc/host.conf

echo "Secured network"




echo "Done"
clear
