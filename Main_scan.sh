#!/bin/bash

logfile=logs/scan.log

count=0
endloop=1000000

while [ $count -lt $endloop ]
do
    terminate=$(cat terminate)
    if [ $terminate -eq  "1" ];
        then
        echo "Terminating..."
        break
    fi
    echo "------------------------------------" | tee -a $logfile
    echo "Scan count: $count" | tee -a $logfile
    echo "Date: $(date +%Y%m%d_%T.%4N)" | tee -a $logfile

    echo "Start arpscan." | tee -a $logfile
    ./arpscan.sh | tee -a $logfile
    echo "" | tee -a $logfile
    echo "Filt with whitelist." | tee -a $logfile
    ./whitelist.sh | tee -a $logfile
    echo "Done." | tee -a $logfile
    echo "" | tee -a $logfile

    rest=$(shuf -i 250-1500 -n1)
    echo "Next scan in $rest seconds" | tee -a $logfile
    echo "" | tee -a $logfile
    sleep $rest

    count=`expr $count + 1`
done

echo "bye bye!"
