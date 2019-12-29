#########################################################
# bash_ping_scan.sh					#
# searches for live network node in a subnet		#
# ./bash_ping_scan.sh 192.168.0				#
# will check 192.168.0.1 to 254				#
# modified by Ashok Shankar Das- ashok.s.das@gmail.com	#
# Copyright (C) 2019 GNU GPL V3 or latter		#
#########################################################
#!/bin/bash

is_alive_ping()
{
  ping -c 1 $1 > /dev/null
  [ $? -eq 0 ] && echo Node with IP: $i is up.
}

for i in $1.{1..254} 
do
is_alive_ping $i & disown
done

