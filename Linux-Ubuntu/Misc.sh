#!/bin/bash

ufw enable
sysctl -n net.ipv4.tcp_syncookies
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
echo "nospoof on" | sudo tee -a /etc/host.conf

sysctl -w net.ipv4.tcp_syncookies=1
sysctl -w net.ipv4.ip_forward=0
sysctl -w net.ipv4.conf.all.send_redirects=0
sysctl -w net.ipv4.conf.default.send_redirects=0
sysctl -w net.ipv4.conf.all.accept_redirects=0
sysctl -w net.ipv4.conf.default.accept_redirects=0
sysctl -w net.ipv4.conf.all.secure_redirects=0
sysctl -w net.ipv4.conf.default.secure_redirects=0
sysctl -p

echo "Secured network"

unalias -a
usermod -L root
chmod 640 .bash_history
chmod 604 /etc/shadow

cp /etc/rc.local ~/Desktop/backups/
echo > /etc/rc.local
echo 'exit 0' >> /etc/rc.local

apt-get install ufw -y -qq
ufw enable
ufw deny 1337

env i='() { :;}; echo Your system is Bash vulnerable' bash -c "echo Bash vulnerability test"

chmod 777 /etc/hosts
cp /etc/hosts ~/Desktop/backups/
echo > /etc/hosts
echo -e "127.0.0.1 localhost\n127.0.1.1 $USER\n::1 ip6-localhost ip6-loopback\nfe00::0 ip6-localnet\nff00::0 ip6-mcastprefix\nff02::1 ip6-allnodes\nff02::2 ip6-allrouters" >> /etc/hosts
chmod 644 /etc/hosts

chmod 777 /etc/lightdm/lightdm.conf
cp /etc/lightdm/lightdm.conf ~/Desktop/backups/
echo > /etc/lightdm/lightdm.conf
echo -e '[SeatDefaults]\nallow-guest=false\ngreeter-hide-users=true\ngreeter-show-manual-login=true' >> /etc/lightdm/lightdm.conf
chmod 644 /etc/lightdm/lightdm.conf

find /bin/ -name "*.sh" -type f -delete

cp /etc/default/irqbalance ~/Desktop/backups/
echo > /etc/default/irqbalance
echo -e "#Configuration for the irqbalance daemon\n\n#Should irqbalance be enabled?\nENABLED=\"0\"\n#Balance the IRQs only once?\nONESHOT=\"0\"" >> /etc/default/irqbalance

cp /etc/sysctl.conf ~/Desktop/backups/
echo > /etc/sysctl.conf
echo -e "# Controls IP packet forwarding\nnet.ipv4.ip_forward = 0\n\n# IP Spoofing protection\nnet.ipv4.conf.all.rp_filter = 1\nnet.ipv4.conf.default.rp_filter = 1\n\n# Ignore ICMP broadcast requests\nnet.ipv4.icmp_echo_ignore_broadcasts = 1\n\n# Disable source packet routing\nnet.ipv4.conf.all.accept_source_route = 0\nnet.ipv6.conf.all.accept_source_route = 0\nnet.ipv4.conf.default.accept_source_route = 0\nnet.ipv6.conf.default.accept_source_route = 0\n\n# Ignore send redirects\nnet.ipv4.conf.all.send_redirects = 0\nnet.ipv4.conf.default.send_redirects = 0\n\n# Block SYN attacks\nnet.ipv4.tcp_syncookies = 1\nnet.ipv4.tcp_max_syn_backlog = 2048\nnet.ipv4.tcp_synack_retries = 2\nnet.ipv4.tcp_syn_retries = 5\n\n# Log Martians\nnet.ipv4.conf.all.log_martians = 1\nnet.ipv4.icmp_ignore_bogus_error_responses = 1\n\n# Ignore ICMP redirects\nnet.ipv4.conf.all.accept_redirects = 0\nnet.ipv6.conf.all.accept_redirects = 0\nnet.ipv4.conf.default.accept_redirects = 0\nnet.ipv6.conf.default.accept_redirects = 0\n\n# Ignore Directed pings\nnet.ipv4.icmp_echo_ignore_all = 1\n\n# Accept Redirects? No, this is not router\nnet.ipv4.conf.all.secure_redirects = 0\n\n# Log packets with impossible addresses to kernel log? yes\nnet.ipv4.conf.default.secure_redirects = 0\n\n########## IPv6 networking start ##############\n# Number of Router Solicitations to send until assuming no routers are present.\n# This is host and not router\nnet.ipv6.conf.default.router_solicitations = 0\n\n# Accept Router Preference in RA?\nnet.ipv6.conf.default.accept_ra_rtr_pref = 0\n\n# Learn Prefix Information in Router Advertisement\nnet.ipv6.conf.default.accept_ra_pinfo = 0\n\n# Setting controls whether the system will accept Hop Limit settings from a router advertisement\nnet.ipv6.conf.default.accept_ra_defrtr = 0\n\n#router advertisements can cause the system to assign a global unicast address to an interface\nnet.ipv6.conf.default.autoconf = 0\n\n#how many neighbor solicitations to send out per address?\nnet.ipv6.conf.default.dad_transmits = 0\n\n# How many global unicast IPv6 addresses can be assigned to each interface?
net.ipv6.conf.default.max_addresses = 1\n\n########## IPv6 networking ends ##############" >> /etc/sysctl.conf
sysctl -p >> /dev/null

echo -e "\n\n# Disable IPv6\nnet.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p >> /dev/null

apt-get install iptables -y -qq
iptables -A INPUT -p all -s localhost  -i eth0 -j DROP

cp /etc/init/control-alt-delete.conf ~/Desktop/backups/
sed '/^exec/ c\exec false' /etc/init/control-alt-delete.conf

apt-get install apparmor apparmor-profiles -y -qq

crontab -l > ~/Desktop/backups/crontab-old
crontab -r

cd /etc/
/bin/rm -f cron.deny at.deny
echo root >cron.allow
echo root >at.allow
/bin/chown root:root cron.allow at.allow
/bin/chmod 400 cron.allow at.allow
cd ..

chmod 777 /etc/apt/apt.conf.d/10periodic
cp /etc/apt/apt.conf.d/10periodic ~/Desktop/backups/
echo -e "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Download-Upgradeable-Packages \"1\";\nAPT::Periodic::AutocleanInterval \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/10periodic
chmod 644 /etc/apt/apt.conf.d/10periodic

apt-get autoremove -y -qq
apt-get autoclean -y -qq
apt-get clean -y -qq

apt-get update
apt-get upgrade openssl libssl-dev
apt-cache policy openssl libssl-dev

clear

echo "Checking for UIDs that are 0"

touch /zerouidusers
touch /uidusers
cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > /zerouidusers

if [ -s /zerouidusers ]
then
  echo "There are Zero UID Users! I'm fixing it now!"

  while IFS='' read -r line || [[ -n "$line" ]]; do
    thing=1
    while true; do
      rand=$(( ( RANDOM % 999 ) + 1000))
      cut -d: -f1,3 /etc/passwd | egrep ":$rand$" | cut -d: -f1 > /uidusers
      if [ -s /uidusers ]
      then
        echo "Couldn't find unused UID. Trying Again... "
      else
        break
      fi
    done
    usermod -u $rand -g $rand -o $line
    touch /tmp/oldstring
    old=$(grep "$line" /etc/passwd)
    echo $old > /tmp/oldstring
    sed -i "s~0:0~$rand:$rand~" /tmp/oldstring
    new=$(cat /tmp/oldstring)
    sed -i "s~$old~$new~" /etc/passwd
    echo "ZeroUID User: $line"
    echo "Assigned UID: $rand"
  done < "/zerouidusers"
  update-passwd
  cut -d: -f1,3 /etc/passwd | egrep ':0$' | cut -d: -f1 | grep -v root > /zerouidusers

  if [ -s /zerouidusers ]
  then
    echo "WARNING: UID CHANGE UNSUCCESSFUL!"
  else
    echo "Successfully Changed Zero UIDs!"
  fi
else
  echo "No Zero UID Users"
fi

clear

cut -d: -f1,3 /etc/passwd | egrep ':[0-9]{4}$' | cut -d: -f1 > /tmp/listofusers
echo root >> /tmp/listofusers

#Replace sources.list with safe reference file (For Ubuntu 14 Only)
cat $PWDthi/referenceFiles/sources.list > /etc/apt/sources.list
apt-get update

#Replace lightdm.conf with safe reference file
cat $PWDthi/referenceFiles/lightdm.conf > /etc/lightdm/lightdm.conf

#Replace sshd_config with safe reference file
cat $PWDthi/referenceFiles/sshd_config > /etc/ssh/sshd_config
/usr/sbin/sshd -t
systemctl restart sshd.service

#/etc/rc.local should be empty except for 'exit 0'
echo 'exit 0' > /etc/rc.local

nano /etc/resolv.conf #make sure if safe, use 8.8.8.8 for name server
nano /etc/hosts #make sure is not redirecting
visudo #make sure sudoers file is clean. There should be no "NOPASSWD"
nano /tmp/listofusers #No unauthorized users

# Netcat backdoors
lsof -i -n -P
netstat -tulpn

#chkrootkit
echo "\033[1;31mStarting CHKROOTKIT scan...\033[0m\n"
chkrootkit -q


#Rkhunter
echo "\033[1;31mStarting RKHUNTER scan...\033[0m\n"
rkhunter --update
rkhunter --propupd #Run this once at install
rkhunter -c --enable all --disable none


#Lynis
echo "\033[1;31mStarting LYNIS scan...\033[0m\n"
cd /usr/share/lynis/
/usr/share/lynis/lynis update info
/usr/share/lynis/lynis audit system


#ClamAV
echo "\033[1;31mStarting CLAMAV scan...\033[0m\n"
systemctl stop clamav-freshclam
freshclam --stdout
systemctl start clamav-freshclam
clamscan -r -i --stdout --exclude-dir="^/sys" /


clear
