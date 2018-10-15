require("luci.sys")
m=Map("scDial", "移动", "配置宽带账号密码，授权码不正确请联系卖家解决，升级系统之前请备份授权码(务必妥善保管授权码)。该设备机器码为 4C11D164B498D33B3127")
s = m:section(TypedSection, "login", "")
s.addremove = false
s.anonymous = true
enable = s:option(Flag, "enable", translate("Enable"),"是否启用断网重连")
name = s:option(Value, "username", translate("Username"))
pass = s:option(Value, "password", translate("Password"))
AuthCode = s:option(Value, "AuthCode", "授权码","未获取到wan口信号，请用电脑客户端拨号测试wan口网线是否可用。若可用，请重启路由器。")

Operator = s:option(ListValue, "Operator", "认证方式")
Operator:value("0","无线")
Operator:value("1","有线")

 
local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("killall mainLogic.sh")
    io.popen("/etc/init.d/scDial restart")
end

return m
