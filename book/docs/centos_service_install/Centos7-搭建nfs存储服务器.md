名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
nfs  server ip|192.168.199.101
远程挂载nfs client ip|192.168.199.102

####nfs server：192.168.199.101执行
```
#关闭屏保
setterm -blank 0

#安装软件
yum install -y nfs-u* rpcbind

#启动服务并设置开机启动
systemctl start rpcbind
systemctl enable rpcbind

systemctl start nfs-server
systemctl enable nfs-server

#安装扫描软件
yum install -y */showmount

#创建共享目录
mkdir /share

#配置参数
#/etc/exports配置文件的格式是：
#NFS共享的目录    NFS客户端地址（参数1，参数2）

vim /etc/exports
/share  *(rw,async,no_root_squash)

#测试是否成功
exportfs -avr

```

####远程挂载nfs client：192.168.199.102 执行
```
#安装扫描软件
yum install -y */showmount

#查看nfs服务器
[root@iscsi ~]# showmount -e 192.168.199.101
Export list for 192.168.199.101:
/share *

#挂载nfs目录/share至本机目录/mnt
[root@iscsi ~]# mount 192.168.199.101:/share /mnt

#解除挂载
umount /mnt
```
