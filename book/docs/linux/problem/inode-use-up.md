###1.描述：磁盘还有空间，可是不能创建文件

###2.原因：inode号使用完毕

###3.解决方案：删除文件size为0的临时文件。
####3.1查询硬盘空间：df -h

```
[root@mkdocs /]# df -h
Filesystem               Size  Used Avail Use% Mounted on
/dev/mapper/centos-root   50G  5.3G   45G  11% /
devtmpfs                 3.9G     0  3.9G   0% /dev
tmpfs                    3.9G     0  3.9G   0% /dev/shm
tmpfs                    3.9G   20M  3.8G   1% /run
tmpfs                    3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/sda1               1014M  216M  799M  22% /boot
/dev/mapper/centos-home  142G   33M  142G   1% /home
tmpfs                    782M  8.0K  782M   1% /run/user/0
/dev/sr0                 918M  918M     0 100% /run/media/root/CentOS 7 x86_64
```

####3.2查询ionde号使用情况：df -i
```
[root@mkdocs /]# df -i
Filesystem                Inodes  IUsed    IFree IUse% Mounted on
/dev/mapper/centos-root 26214400 173052 26041348    1% /
devtmpfs                  997009    417   996592    1% /dev
tmpfs                    1000000      1   999999    1% /dev/shm
tmpfs                    1000000   1380   998620    1% /run
tmpfs                    1000000     16   999984    1% /sys/fs/cgroup
/dev/sda1                 524288    348   523940    1% /boot
/dev/mapper/centos-home 73986048      7 73986041    1% /home
tmpfs                    1000000      9   999991    1% /run/user/0
/dev/sr0                       0      0        0     - /run/media/root/CentOS 7 x86_64
```


####3.3释放inode。删除无用的临时文件
```
#挨个目录查询使用的inode号：
ls -lt /文件目录 | wc -l
#删除文件大小为0的文件释放inode号：
sudo find /文件目录 -type f -size 0 -exec rm {} \;  
```
###4.注意：
新建磁盘是优化inode号大小，指定inode号占用的最小字节为4k，这样分区就会有尽量多的inode号：
命令设置inode占用大小，在创建磁盘时有效
```
mke2fs -i 4096 -t ext4 /sev/sdb1
```