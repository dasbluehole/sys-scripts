#########################################################
# network_speed_mon.sh					#
# https://www.pixelstech.net/article/1377917732-Server-	#
# monitoring-shell-scripts				#
# modified by Ashok Shankar Das- ashok.s.das@gmail.com	#
# Copyright (C) 2019 GNU GPL V3 or latter		#
# this script only work for single configured interface	#
#########################################################
#!/bin/bash
#network
#Mike.Xu
IFACE=`ip addr | awk '/state UP/ {print $2}' | sed 's/.$//'`
while : ; do
      #time=`date +%m"-"%d" "%k":"%M`
      #day=`date +%m"-"%d`
      time=`date +%d"/"%m"/"%Y"-"%k":"%M":"%S`
      rx_before=`ifconfig $IFACE|sed -n "5"p|awk '{print $5}'`
      tx_before=`ifconfig $IFACE|sed -n "7"p|awk '{print $5}'`
      sleep 2
      rx_after=`ifconfig $IFACE|sed -n "5"p|awk '{print $5}'`
      tx_after=`ifconfig $IFACE|sed -n "7"p|awk '{print $5}'`
#      echo $rx_before" - "$rx_after"= "$[(rx_after-rx_before)]" bytes incoming in 2 seconds"


	rx_result=$[(rx_after-rx_before)/(2*1024)]
	tx_result=$[(tx_after-tx_before)/(2*1024)]
      echo "$time Now_In_Speed: "$rx_result"kbps Now_OUt_Speed: "$tx_result"kbps"
      sleep 2
done

