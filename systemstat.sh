#########################################################
# systemstat.sh						#
#Adopted from http://www.systeen.com/2016/05/07/bash-   #
#script-monitor-cpu-memory-disk-usage-linux/		#
#Modified by Ashok Shankar Das- ashok.s.das@gmail.com   #
#Copyright (C) 2019 GNU GPL V3 or latter		#
#########################################################
#! /bin/bash
PREV_TOTAL=0
PREV_IDLE=0
MCPU=0
cpu()
{
#copied from https://github.com/pcolby/scripts/blob/master/cpu.sh
# Get the total CPU statistics, discarding the 'cpu ' prefix.
  CPU=($(sed -n 's/^cpu\s//p' /proc/stat))
  IDLE=${CPU[3]} # Just the idle CPU time.
 
  # Calculate the total CPU time.
  TOTAL=0
  for VALUE in "${CPU[@]:0:8}"; do
    TOTAL=$((TOTAL+VALUE))
  done
 
  # Calculate the CPU usage since we last checked.
  DIFF_IDLE=$((IDLE-PREV_IDLE))
  DIFF_TOTAL=$((TOTAL-PREV_TOTAL))
  DIFF_USAGE=$(((1000*(DIFF_TOTAL-DIFF_IDLE)/DIFF_TOTAL+5)/10))
  #echo -en "\rCPU: $DIFF_USAGE%  \b\b"
  MCPU=$DIFF_USAGE
  #echo $MCPU
  # Remember the total and idle CPU times for the next check.
  PREV_TOTAL="$TOTAL"
  PREV_IDLE="$IDLE"
}
printf "Date\t\t\tMemory\t\t/\t\t/home\t\tCPU\t\tNet-rx\t\tNet-tx\n"
end=$((SECONDS+3600))
while [ $SECONDS -lt $end ]; do
MEMORY=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
DISK_r=$(df -h | awk '$NF=="/"{printf "%s\t\t", $5}')
DISK_h=$(df -h | awk '$NF=="/home"{printf "%s\t\t", $5}')
#CPU=$(top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}')
cpu
NRX=$(netstat -i | awk 'NR>2'|awk '{print $3}'|paste -sd+ - | bc)
NTX=$(netstat -i | awk 'NR>2'|awk '{print $7}'|paste -sd+ - | bc)
DATE=$(date +%d"/"%m"/"%Y"-"%k":"%M":"%S)
echo -e "$DATE	$MEMORY$DISK_r$DISK_h$MCPU%\t\t$NRX\t\t$NTX"
sleep 1
done
