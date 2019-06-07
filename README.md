# crack_web
## CopyRight:QingHui  
## Time:2018/10  

### 代码起源：
这个小项目是本科期间闲来无事写的一个几乎纯脚本用于在openwrt上过校园网网页认证的程序。就是开一个账号，大家一起用嘛，也不用手动去登陆了，嘿嘿嘿。。。  

### 核心思路及代码：  
大部分校园网的网页认证实际上就是POST一个认证包即可以完成认证，也不需要去发送心跳包去保持在线，实际上还是很好实现的。这里我以我本科的学校为例子作为示范，抓包分析编写认证的核心代码。抓包的工具使用wireshark，步骤就是认证之前开启wireshark抓包，登陆后停止抓包就捕获到认证期间的数据包了，这段部分比较简单，网上也有更详细的教程就不缀叙。那么我们需要筛选这个POST包，可以查找认证的关键字去找这个包： 
![image](https://github.com/a1094174619/crack_web/tree/master/image/wireless.png "POST包抓取")  
   
分析这个包可以得到post的关键字段：  
![image]( https://github.com/a1094174619/crack_web/tree/master/image/parameter.png)  
	这样我们只需要模拟出这个包结构，让路由器发送这个POST包就可以实验路由器认证了。那么模拟POST包可以使用openwrt平台上的curl工具，得到以下代码（这段代码与上面的抓包演示不对应，但原理相同）：
  
    curl "http://172.16.245.50/include/auth_action.php" -d "action=login&username=$1&password=$2&ac_id=2&nas_ip=&user_mac=&save_me=1&ajax=1" -H "Connection: keep-alive" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: zh-CN,zh;q=0.8" -H "Content-Type: application/x-www-form-urlencoded"  

其中的关键信息包含username,password。为了测试你可以在windows平台使用curl这个工具去测试你使用的代码是否能够使用。若能使用的话，只需要找一台有curl工具的openwrt路由器后，将代码打包为脚本并加入开机启动便可以实现自动认证了！。  
那么为了去实现一个luci界面和一个根据mac进行授权码加密的功能便有了以下代码及其luci界面（有实力的小伙伴对路由器加密可以使用华邦芯片的唯一标识码，需要改动openwrt的一些源代码来实现硬件绑定加密。）：  
![image]( https://github.com/a1094174619/crack_web/tree/master/image/luci.png)  
 
### 代码使用方式：  
1.需要一台有curl工具的openwrt路由器可以自己编译也可以使用openwrt官方的固件并安装curl及其安装包。  
2.因为都是用脚本写的，故所有的文件均是直接替换至路由器的目录，并给相应的执行脚本加上执行权限后重启路由器即可看到luci界面，理论上兼容所有的openwrt路由器，仅有一加密执行文件用c语言编写并交叉编译到ar71xx平台上（需注意）。  
### 代码的各个目录与文件说明：  
/etc目录主要存放配置文件，需给etc/init.d/scDial加上可执行权限  
	/etc/config/wireless中wifi-iface是配置路由器AP+Client桥接的WIFI,因为我本科学校需要无线桥接CMCC-EDU再认证  
/sbin目录只要是代码的可执行文件脚本，需要全部加上可执行权限：  
	/sbin/dial.sh 读取/sbin/dialConfig中账号密码并调用/sbin/dialOnce.sh进行拨号认证  
	/sbin/dialConfig 存储账号密码信息  
	/sbin/encryptMt7620 实际上AR71XX的加密文件，输入字符串（设备mac地址），输出是加密字符串  
	/sbin/isReConnected存储是否启动断网重连的信息  
	/sbin/mainLogic.sh 一系列脚本的主入口  
	/sbin/setPPPresult.sh 将拨号结果传送至luci界面  
	/sbin/showMachineCode.sh 获取MAC地址，并传送至luci界面  
/usr保存界面设计的Luci文件  
/www保存广告信息，可忽略不进行替换  
### 逻辑流程图如下：  
![image]( https://github.com/a1094174619/crack_web/tree/master/image/flow.png)  
仅仅用作学习交流使用！！  
