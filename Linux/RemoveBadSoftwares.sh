#!/bin/bash


apt-get purge netcat -y -qq
apt-get purge netcat-openbsd -y -qq
apt-get purge netcat-traditional -y -qq
apt-get purge ncat -y -qq
apt-get purge pnetcat -y -qq
apt-get purge socat -y -qq
apt-get purge sock -y -qq
apt-get purge socket -y -qq
apt-get purge sbd -y -qq
rm /usr/bin/nc

echo "Netcat and all other instances have been removed."

apt-get purge john -y -qq
apt-get purge john-data -y -qq

echo "John the Ripper has been removed."

apt-get purge hydra -y -qq
apt-get purge hydra-gtk -y -qq

echo "Hydra has been removed."

apt-get purge aircrack-ng -y -qq

echo "Aircrack-NG has been removed."

apt-get purge fcrackzip -y -qq

echo "FCrackZIP has been removed."

apt-get purge lcrack -y -qq

echo "LCrack has been removed."

apt-get purge ophcrack -y -qq
apt-get purge ophcrack-cli -y -qq

echo "OphCrack has been removed."

apt-get purge pdfcrack -y -qq

echo "PDFCrack has been removed."

apt-get purge pyrit -y -qq

echo "Pyrit has been removed."

apt-get purge rarcrack -y -qq

echo "RARCrack has been removed."

apt-get purge sipcrack -y -qq

echo "SipCrack has been removed."

apt-get purge irpas -y -qq

echo "IRPAS has been removed."


echo 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
dpkg -l | egrep "crack|hack" >> ~/Desktop/Script.log

apt-get purge logkeys -y -qq
 
echo "LogKeys has been removed."

apt-get purge zeitgeist-core -y -qq
apt-get purge zeitgeist-datahub -y -qq
apt-get purge python-zeitgeist -y -qq
apt-get purge rhythmbox-plugin-zeitgeist -y -qq
apt-get purge zeitgeist -y -qq
echo "Zeitgeist has been removed."

apt-get purge nfs-kernel-server -y -qq
apt-get purge nfs-common -y -qq
apt-get purge portmap -y -qq
apt-get purge rpcbind -y -qq
apt-get purge autofs -y -qq
echo "NFS has been removed."

apt-get purge nginx -y -qq
apt-get purge nginx-common -y -qq
echo "NGINX has been removed."

apt-get purge inetd -y -qq
apt-get purge openbsd-inetd -y -qq
apt-get purge xinetd -y -qq
apt-get purge inetutils-ftp -y -qq
apt-get purge inetutils-ftpd -y -qq
apt-get purge inetutils-inetd -y -qq
apt-get purge inetutils-ping -y -qq
apt-get purge inetutils-syslogd -y -qq
apt-get purge inetutils-talk -y -qq
apt-get purge inetutils-talkd -y -qq
apt-get purge inetutils-telnet -y -qq
apt-get purge inetutils-telnetd -y -qq
apt-get purge inetutils-tools -y -qq
apt-get purge inetutils-traceroute -y -qq
echo "Inetd (super-server) and all inet utilities have been removed."


apt-get purge vnc4server -y -qq
apt-get purge vncsnapshot -y -qq
apt-get purge vtgrab -y -qq
echo "VNC has been removed."


apt-get purge snmp -y -qq
echo "SNMP has been removed."


# NOT DONE, NEED TO ADD NMAP AND MORE SOFTWARES!!
