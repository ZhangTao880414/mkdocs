
名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
 1、使用全新的命令行工具 nmcli 来设置
```
#显示当前网络连接
nmcli connection show
NAME UUID                                 TYPE           DEVICE
eno1 5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03 802-3-ethernet eno1

#修改当前网络连接对应的DNS服务器，这里的网络连接可以用DEVICE或者UUID来标识
nmcli con mod eno1 ipv4.dns "114.114.114.114 8.8.8.8"

#将dns配置生效
nmcli con up eno1

````
2、使用传统方法，手工修改 /etc/resolv.conf
```
vim /etc/NetworkManager/NetworkManager.conf
#在main部分添加 “dns=none” 选项,如下：
[main]
plugins=ifcfg-rh
dns=none

#编辑文件
vim /etc/resolv.conf
nameserver 114.114.114.114
nameserver 8.8.8.8

#重启服务
systemctl restart NetworkManager.service

#刷新dns
systemctl restart nscd


