名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
iscsi ip|192.168.199.100

```
#安装软件
yum install -y target*

#启动并设置开机启动
systemctl start target
systemctl enable target

#虚拟机中添加一块20G的硬盘

#查看硬盘存储情况 （sdb 为新添加的硬盘）
[root@iscsi ~]# lsblk
NAME            MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
fd0               2:0    1     4K  0 disk 
sda               8:0    0   200G  0 disk 
├─sda1            8:1    0     1G  0 part /boot
└─sda2            8:2    0   199G  0 part 
  ├─centos-root 253:0    0    50G  0 lvm  /
  ├─centos-swap 253:1    0   7.9G  0 lvm  
  └─centos-home 253:2    0 141.1G  0 lvm  /home
sdb               8:16   0    20G  0 disk 
sr0              11:0    1   918M  0 rom  


#划分一个10G存储分区，为sda3
fdisk /dev/sdb 

1，输入：n

　　表示创建一个新的分区（new的意思）

　　2，输入：p

　　表示创建一个基本分区（p是基本分区，e是扩展分区）

　　3，选择分区编号，1~4，默认使用1，直接按回车即可。

　　4，选择分区起始点，使用默认即可，直接按回车。

　　5，选择分区终点，使用默认即可，直接按回车全部分配 或者 +10G（分配10G）

　　6，分区完成保存。w

#更新分区表
partprobe /dev/sdb

#进入iscsi设置
targetcli
#列出信息
ls
#创建共享盘共享盘
/backstores/block create block1 /dev/sdb1

#删除共享盘block1
/backstores/block delete block1

#创建iscsi  注意2019-4会失败
/iscsi create iqn.2019-04.cc.rhce:disk

#添加acls 
cd  /iscsi/iqn.2019-04.cc.rhce:disk/tpg1
acls/ create iqn.2019-04.cc.rhce:xx
#添加luns
luns/ create /backstores/block/block1

#退出targetcli设置
exit

#查看是否运行
yum install -y net-tools
netstat -ntulp |grep 3260

```