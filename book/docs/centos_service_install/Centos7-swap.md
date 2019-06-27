名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 

1.暂时关闭SWAP，重启后恢复
```
swapoff   -a
```
2.暂时开启SWAP，重启后恢复
```
swapon   -a
```

3. 永久关闭SWAP
```
vim /etc/fstab
#注释掉SWAP分区项，即可
# swap was on /dev/sda11 during installation
#UUID=0a55fdb5-a9d8-4215-80f7-f42f75644f69 none  swap    sw      0       0

#刷新swap使之生效
sysctl -p

```
