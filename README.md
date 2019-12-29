# sys-scripts
System admin scripts
These scripts are created/used by me to check different parameters on a client's server.
**bash_ping_scan.sh** is to discover nodes on a LAN. 
                    
Usage is ***bash bash_ping_scan.sh 192.168.0***
this will scan 192.168.0.1 to 192.169.0.254 and only display nodes which are up.

**network_speed_mon.sh** is to find network speed of the machine.
                    
usage is ***bash network_speed_mon.sh***

**systemstat.sh** is to get system statistics every 5 seconds. It shows 

|Date		            |	Memory	|	/	  |/home|	CPU	  |	Net-rx	|	Net-tx|

|-------------------------------------------------------------------|

|29/12/2019-21:23:18|	36.07%	|	26%	|	25%	|	0.01% |	474953	|	276478|

|29/12/2019-21:23:23|	36.04%	|	26%	|	25%	|	0.01%	|	474955	|	276479|


**dd/mm/yyyy-hh:MM:ss  memory used diskspace used /   diskspace used /home cpu Net_rx Net_tx**

usage is ***bash systemstat.sh***
