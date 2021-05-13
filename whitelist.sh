#!/bin/bash

iplist_eth=targets/iplist_eth.txt
iplist_wlan=targets/iplist_wlan.txt

whilelist_eth=targets/whitelist_eth.txt
whilelist_wlan=targets/whitelist_wlan.txt

# read out whitelist line by line

while IFS= read -r line
do
  target_eth=$(echo "$line" | awk '{ print $1; }')
  echo "deleting $target_eth from $iplist_eth"
  sed "/$target_eth/d" -i $iplist_eth
done < "$whilelist_eth"

while IFS= read -r line
do
  target_wlan=$(echo "$line" | awk '{ print $1; }')
  echo "deleting $target_wlan from $iplist_wlan"
  sed "/$target_wlan/d" -i $iplist_wlan
done < "$whilelist_wlan"

eth_count=$(wc -l targets/iplist_eth.txt)
wlan_count=$(wc -l targets/iplist_wlan.txt)
echo "Left $eth_count in eth"
echo "Left $wlan_count in wlan"
