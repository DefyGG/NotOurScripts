#!/bin/bash

#Lock people from logging straight into the root account
passwd -l root
echo "Finished locking the root account"

#Change the ownership and permissions of files that could commonly be exploited otherwise
chown root:root /etc/securetty
chmod 0600 /etc/securetty
chmod 644 /etc/crontab
chmod 640 /etc/ftpusers
chmod 440 /etc/inetd.conf
chmod 440 /etc/xinetd.conf
chmod 400 /etc/inetd.d
chmod 644 /etc/hosts.allow
chmod 440 /etc/sudoers
chmod 640 /etc/shadow
chown root:root /etc/shadow
echo "Finished changing permissions"

yes "CyberPatriots2020" | passwd
echo "Finished with changing root password"

#Change all the user passwords
#For every user in the /etc/passwd file who has a UID >500 (generally newly added user), changes their password.
for i in $(cat /etc/passwd | cut -d: -f 1,3,6 | grep -e "[5-9][0-9][0-9]" -e "[0-9][0-9][0-9][0-9]" | grep "/home" | cut -d: -f1) ; do 
	yes "CyberPatriots2020" | passwd $i ;
	#This changes in the shadow file the max and min password days
	passwd -x 90 $i;
	passwd -n 10 $i;
	#save the history into the log directory
	cp /home/$i/.bash_history /logs/$i
	echo $i  >> usersChanged.txt
done;
echo "Finished with changing all passwords"


#Delete bad users
#For every user in /etc/passwd file who isn’t mentioned in the README, removes them and deletes everything they have
for i in $(cat /etc/passwd | cut -d: -f 1,3,6 | grep -e "[5-9][0-9][0-9]" -e "[0-9][0-9][0-9][0-9]" | grep "/home" | cut -d: -f1) ; do
	if [[ $( grep -ic -e $i $(pwd)/README ) -eq 0 ]]; then	
		(deluser $i --remove-all-files >> RemovingUsers.txt 2>&1) &  #starts deleting in background
	fi
done
echo "Finished with deleting bad users"

#For everyone in the addusers file, creates the user
echo "" >> addusers.txt
for i in $(cat $(pwd)/addusers.txt); do
	useradd $i;
done
echo "Finished adding users"

#Goes and makes users admin/not admin as needed
#for every user with UID above 500 that has a home directory
for i in $(cat /etc/passwd | cut -d: -f 1,3,6 | grep -e "[5-9][0-9][0-9]" -e "[0-9][0-9][0-9][0-9]" | grep "/home" | cut -d: -f1); do
	#If the user is supposed to be a normal user but is in the sudo group, remove them from sudo
	BadUser=0
	if [[ $( grep -ic $i $(pwd)/users.txt ) -ne 0 ]]; then	
		if [[ $( echo $( grep "sudo" /etc/group) | grep -ic $i ) -ne 0 ]]; then	
			#if username is in sudo when shouldn’t
			deluser $i sudo;
			echo "removing $i from sudo" >> usersChanged.txt
		fi
if [[ $( echo $( grep "adm" /etc/group) | grep -ic $i ) -ne 0 ]]; then	
			#if username is in adm when shouldn’t
			deluser $i adm;
			echo "removing $i from adm" >> usersChanged.txt
		fi
	else
		BadUser=$((BadUser+1));
	fi
	#If user is supposed to be an adm but isn’t, raise privilege.
	if [[ $( grep -ic $i $(pwd)/admin.txt ) -ne 0 ]]; then	
		if [[ $( echo $( grep "sudo" /etc/group) | grep -ic $i ) -eq 0 ]]; then	
			#if username isn't in sudo when should
			usermod -a -G "sudo" $i
			echo "add $i to sudo"  >> usersChanged.txt
		fi
if [[ $( echo $( grep "adm" /etc/group) | grep -ic $i ) -eq 0 ]]; then	
			#if username isn't in adm when should
			usermod -a -G "adm" $i
			echo "add $i to adm"  >> usersChanged.txt
		fi
	else
		BadUser=$((BadUser+1));
	fi
	if [[ $BadUser -eq 2 ]]; then
		echo "WARNING: USER $i HAS AN ID THAT IS CONSISTENT WITH A NEWLY ADDED USER YET IS NOT MENTIONED IN EITHER THE admin.txt OR users.txt FILE. LOOK INTO THIS." >> usersChanged.txt
	fi
done
echo "Finished changing users"


echo "Done with users"
clear
