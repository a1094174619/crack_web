#!/bin/sh

echo $1
echo $2
echo $3

local authCode=$3
local machineCode=$(/sbin/dial7620 -hwcode)
local rightCode=$(/sbin/encryptMT7620 $machineCode)

if [ "$authCode" == "$rightCode" ]
then
	echo "authcode is right"

	if [ $(cat "/sbin/authWay") -eq 0 ]  
	then
		echo "start wireless Auth"
		
		#open eth
		sleep 5
		curl "http://172.16.245.50/include/auth_action.php" -d "action=login&username=$1&password=$2&ac_id=2&nas_ip=&user_mac=&save_me=1&ajax=1" -H "Connection: keep-alive" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.8" -H "Content-Type: application/x-www-form-urlencoded"
	else
		#wire Auth Way
		echo "start wire Auth"
	
	fi
else
	/sbin/showDialStatus.sh "授权码错误"
fi
