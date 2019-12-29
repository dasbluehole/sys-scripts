#########################################################
# systemstat.sh						#
#Adopted from http://www.systeen.com/2016/05/07/bash-   #
#script-monitor-cpu-memory-disk-usage-linux/		#
#Modified by Ashok Shankar Das- ashok.s.das@gmail.com   #
#Copyright (C) 2019 GNU GPL V3 or latter		#
#########################################################
#! /bin/bash

printf "Date\t\t\tMemory\t\t/\t\t/home\t\tCPU\t\tNet-rx\t\tNet-tx\n"
end=$((SECONDS+3600))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK_r=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
DISK_h=$(df -h | awk '$NF=="/home"{printf "%s\t\t", $5}')
CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
NRX=$(netstat -i | awk 'NR>2'|awk '{print $3}'|paste -sd+ - | bc)
NTX=$(netstat -i | awk 'NR>2'|awk '{print $7}'|paste -sd+ - | bc)
DATE=$(date +%d"/"%m"/"%Y"-"%k":"%M":"%S)
echo "$DATE	$MEMORY$DISK_r$DISK_h$CPU$NRX		$NTX"
sleep 5
done
