名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
IP|192.168.199.131
#1.配置hostname 为k8s-node1
```
hostnamectl set-hostname k8s-node1
```
#2.配置hosts解析
```
vim /etc/hosts
```
添加（中间三个空格）
```
192.168.199.131   k8s-node1
```
#3.重启网络服务
```
/etc/init.d/network restart
```
#4.查看当前hostname
```
hostname
```