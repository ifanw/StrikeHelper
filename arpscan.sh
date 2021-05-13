#!/bin/bash
iplist_eth=targets/iplist_eth.txt
iplist_wlan=targets/iplist_wlan.txt

echo "Ping all device in network......"
# Ping all ip inside lan
for ip in 192.168.10.{1..254}; do
    # Delete old arp data
    sudo arp -d $ip > /dev/null 2>&1
    # Get arp info by ping
    ping -c 5 $ip > /dev/null 2>&1 &
done
for ip in 192.168.21.{1..254}; do
    # Delete old arp data
    sudo arp -d $ip > /dev/null 2>&1
    # Get arp info by ping
    ping -c 5 $ip > /dev/null 2>&1 &
done


echo "Started......let's wait"

wait

# output ARP table
# arp -n | grep -v incomplete
echo "Done...save mac table"
arp -n -i eth0 | grep 192.168 | grep -v 254 | grep -v incomplete > $iplist_eth
arp -n -i wlan0 | grep 192.168 | grep -v 254 | grep -v incomplete > $iplist_wlan

eth_count=$(wc -l targets/iplist_eth.txt)
wlan_count=$(wc -l targets/iplist_wlan.txt)
echo "Found $eth_count in eth"
echo "Found $wlan_count in wlan"
