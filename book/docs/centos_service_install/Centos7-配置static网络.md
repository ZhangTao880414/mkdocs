名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 

#1.编辑网络配置文件

```
vi /etc/sysconfig/network-scripts/ifcfg-ens33
#将 ONBOOT=no 改为 ONBOOT=yes
```
#2. 执行网络重启命令 
```
systemctl restart network.service
```
#3.命令查看dhcp获取的网络地址

```
ip add

#获取信息格如下：注意： inet 192.168.199.135/24 brd 192.168.199.255
ens33: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 00:0c:29:57:ff:af brd ff:ff:ff:ff:ff:ff
    inet 192.168.199.135/24 brd 192.168.199.255 scope global noprefixroute ens33
      valid_lft forever preferred_lft forever
    inet6 fe80::1a08:23ff:3bfc:7479/64 scope link noprefixroute
      valid_lft forever preferred_lft forever
```
#4.修改网络配置文件
```
vi /etc/sysconfig/network-scripts/ifcfg-ens33
#修改 BOOTPROTO=dhcp 为 BOOTPROTO=static
#增加四行信息并保存：

IPADDR="192.168.199.135"
NETMASK="255.255.255.0"
GATEWAY="192.168.199.1"
DNS1="192.168.199.1"

```

#5.重启网络服务 
```
systemctl restart network.service
```
#6.测试网络是否连通
```
ping www.baidu.com 
```
得到类似信息表示网络连通
```
PING www.a.shifen.com (119.75.217.26) 56(84) bytes of data.
64 bytes from 119.75.217.26 (119.75.217.26): icmp_seq=1 ttl=51 time=33.6 ms
64 bytes from 119.75.217.26 (119.75.217.26): icmp_seq=2 ttl=51 time=33.5 ms
```
#7.配置网络开机启动 
```
/sbin/chkconfig network on
```
#8.重启机器验证
```
reboot
```