#!/bin/bash

# Make sure to go through the readme and make the users correct and make sure to change the paswords of all admins
# basically what you normally do

unalias -a
usermod -L root
chmod 640 .bash_history
chmod 604 /etc/shadow


passwd -l root
echo "Finished locking the root account"
# CHANGE ROOT PASSWORD ON YOUR OWN, THIS CODE DOESN'T WORK


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

#Remove unwanted alias
echo "Bad Aliases:" > AliasesAndFunctions.txt
for i in $(echo $(alias | grep -vi -e "alias egrep='egrep --color=auto'" -e "alias fgrep='fgrep --color=auto'" -e "alias grep='grep --color=auto'" -e "alias l='ls -CF'" -e "alias la='ls -A'" -e "alias ll='ls -alF'" -e "alias ls='ls --color=auto'" | cut -f 1 -d=) | cut -f 2 -d ' ') ; do 
	echo $(alias | grep -e $i)  >> AliasesAndFunctions.txt;
	unalias $i;
done


echo "Finished unaliasing"


for i in $(grep ":0:" /etc/passwd | grep -v -e "root:x" -e "#"); do
	name=$(echo $i | cut -f1 -d: );
	echo $name
	#(deluser $name --remove-all-files  >> RemovingUsers.txt 2>&1) &    #Doesn’t work, as it fails and if you force it then it deletes root
	lineNumber=$(grep -in  -e $i /etc/passwd | cut -d: -f 1);
	sed -i '/'"$lineNumber"'/s/^/#/' /etc/passwd
	#These two actually find the line where the not root uid 0 is, and then comment that line out
	gnome-terminal -e "bash -c \"( echo "WARNING: THERE IS A HIDDEN ROOT USER ON THE COMPUTER. PLEASE RECTIFY THE SITUATION IMMEDIATELY."; exec bash )\"" & disown; sleep 2; 
	#This disown causes the terminal created to not be associated with the original terminal so when the original is closed it does not also close this one.
done

echo "Done with users"
clear
