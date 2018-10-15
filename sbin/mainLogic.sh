#!/bin/sh
local returnCode

while [ $(cat "/sbin/isReConnected") -eq 1 ]
do
echo "Begin to detect whether the network is Connected!"
if /bin/ping -c 1 182.140.167.44
then
	echo "Internet connected!"
	/sbin/showDialStatus.sh "网络已连接"
else
	if /bin/ping -c 1 114.114.114.114
	then
		echo "ONLINE."
		/sbin/showDialStatus.sh "网络已连接"

	else
		if [ $(cat "/sbin/isReConnected") -eq 1 ]
		then
			echo "RECONN..."
			/sbin/showDialStatus.sh "正在连接中..."
			/sbin/dial.sh
			returnCode=$?
			echo $returnCode
		
			if [ $returnCode -eq 253 ] 
			then
				echo "1"
				/sbin/showDialStatus.sh "授权码错误"
				exit 1 
			else
				if [ $returnCode -eq 255 ] 
				then
					echo "2"
					/sbin/showDialStatus.sh "账号密码不能为空，激活码必须为32字符,请检查是否输入正确"
					exit 1 
				else
					sleep 9
					if  /bin/ping -c 1 114.114.114.114 
					then
						/sbin/showDialStatus.sh "网络已连接"
					else
						/sbin/setPPPresult.sh
					fi
				fi
			fi
		else
			echo "Disconnection reconnection Unable"
		fi
		sleep 15
	fi
fi	
sleep 10		
done
