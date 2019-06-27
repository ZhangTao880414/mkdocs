名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 

 ```
#查看防火墙状态
firewall-cmd --state

#关闭防火墙
systemctl stop firewalld.service

#禁止firewall开机启动
systemctl disable firewalld.service 


#查看selinux状态
sestatus
#临时关闭
setenforce 0
#永久关闭
vi /etc/selinux/config
修改 SELINUX=enforcing为SELINUX=disabled
重启系统生效
reboot

```