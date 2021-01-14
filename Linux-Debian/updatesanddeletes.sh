sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -f -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
sudo apt-get check
sudo apt-get -V -y install firefox chkrootkit ufw gufw clamav
sudo apt-get purge telnet
sudo apt-get -y purge hydra*
sudo apt-get -y purge john* # John the Ripper, brute forcing software
sudo apt-get -y purge nikto* # Website pentesting
# sudo apt-get -y purge netcat* Scans open ports, installed by default?