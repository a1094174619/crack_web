require("luci.sys")
m=Map("wireless", "wifi账号密码", "这里可以修改你的wifi账号密码，也就是你的无线设备（手机、电脑）连接的WIFI账号密码")
s = m:section(TypedSection, "wifi-iface", "")
s.addremove = false
s.anonymous = true

ssid = s:option(Value, "ssid", "wifi名称","中文wifi名称在win7系统将会是乱码")
key = s:option(Value, "key", "wifi密码","请不要使用中文字符,密码必须大于或者等于8位")
encryption = s:option(ListValue, "encryption", "加密方式","none为不加密，psk2为加密")
encryption:value("none")
encryption:value("psk2")



 
local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("/etc/init.d/network restart")
end

return m