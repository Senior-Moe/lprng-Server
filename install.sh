#!/bin/bash
#prng-server  Copyright (C)2024  Mohammed-Alnahdi
#This program comes with ABSOLUTELY NO WARRANTY; for details type GPLv3.
#This is free software, and you are welcome to redistribute it
#under certain conditions; type GPLv3for details. 
#Email: mohammed.alnahdi@outlook.com
#url: https://github.com/Mohammed-Alnahdi


EXIT_SUCCESS=0
EXIT_FAILURE=1

echo "Hello in installation LPRng on Debian Gnu/Linux"
echo "Preparing to install"
# run as root
[ "$EUID" -ne 0 ] \
    && echo -e "\033[41mroot required to execute this script.\033[0m" >&2 \
    && exit $EXIT_FAILURE

# List and stop all CUPS-related systemd services
services=$(systemctl list-units --type=service | grep cups | awk '{print $1}')

for service in $services; do
    systemctl disable $service
    systemctl stop $service
done

# Remove CUPS
echo "Removing CUPS Server"
sleep 3
apt purge cups -y && apt autoremove -y

#update repo:
apt update -y && apt upgrade -y 

# install SAMBA "for sending jobs to printer" and LRPng Server
echo "installing samba and lprng"
sleep 3
apt install samba lprng -y

# Make configration for SAMBA
echo "Make configration for SAMBA"
printf "waite..."
sleep 2
cp /etc/samba/smb.conf /etc/samba/smb.conf.back

smb_path="/etc/samba/smb.conf"

cat smb_configruation > $smb_path

echo "samba configration at $smb_path"

echo "enable SMB and NMB"
sleep 3
systemctl enable --now {n,s}mb.conf

echo "Adding Printer"
sleep 3
echo -e "\033[4;33mEnter Name of Printer\033[0m"
read PrinterName
echo -e "\033[4;33mEnter IP for The Printer\033[0m"
read IPprinter
echo -e "$PrinterName|localprinter:\\
:lp=$IPprinter%9100:\\
:sd=/var/spool/lpd/$PrinterName:\\
:mx#0:\\
:sh:" >> /etc/printcap

cp /etc/lprng/lpd.conf /etc/lprng/lpd.conf.bk
echo "lpd_listen_port = 515" > /etc/lprng/lpd.conf 


pattern="REJECT NOT SERVER"

permission_file="/etc/lprng/lpd.perms"

cp /etc/lprng/lpd.perms /etc/lprng/lpd.perms.bk
sed -i "s/^.*$pattern.*$/# &/" "$permission_file"

echo "Lines containing '$pattern' commented out in $permission_file."
echo -e "\n\033[4;36mRunning lprng\033[0m"
sudo service lprng restart
echo -e "\n\033[4;36mRunning SMB Again\033[0m"
sudo service smbd restart
echo -e "\n\033[4;36mThe Server is Ready\033[0m"
echo -e "\033[41mFinished, Please Read Readme.md file\033[0m" >&2 \
