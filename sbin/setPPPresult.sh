#!/bin/sh

/sbin/showDialStatus.sh "正在连接中..."

sleep 10

local PPPresult

PPPresult="$(echo $(logread|tail -n +$(logread|grep -n "Plugin rp-pppoe.so loaded"|tail -2|head -1|cut -f 1 -d ":")|grep "Remote message"|cut -f 5 -d ":"))"

if [ "$PPPresult" == "" ]
then
	/sbin/showDialStatus.sh "未获取到wan口信号，请用电脑客户端拨号测试wan口网线是否可用。若可用，请重启路由器。"
else
	/sbin/showDialStatus.sh "$PPPresult"
fi


##添加到mainLogic.h和/etc/init.d/scDial
