#!/bin/sh

local filename="/usr/lib/lua/luci/model/cbi/scDial.lua"
local statusStr=$1
local  str="AuthCode = s:option(Value, \"AuthCode\", \"授权码\",\"$statusStr\")"
sed -i "9c ${str}" $filename
