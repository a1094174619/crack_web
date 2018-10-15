#!/bin/sh

local filename="/usr/lib/lua/luci/model/cbi/scDial.lua"

local machineCode=$(/sbin/dial7620 -hwcode)

local  str="m=Map(\"scDial\", \"移动\", \"配置宽带账号密码，授权码不正确请联系卖家解决，升级系统之前请备份授权码(务必妥善保管授权码)。该设备机器码为 $machineCode\")"


sed -i "2c ${str}" $filename
