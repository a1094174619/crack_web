#!/bin/sh

local returnCode

plist=""

for  i in $(cat "/sbin/dialConfig")
do
	plist="$plist $i"
done
echo $plist

#local username=$(awk 'NR==1{print}' "/sbin/dialConfig")


#killall pppd

#/etc/init.d/network restart

/sbin/dialOnce.sh $plist

returnCode=$?

sleep 5

return $returnCode
