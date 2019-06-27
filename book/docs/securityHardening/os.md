###1.系统加固

####1.1 除root外的用户无法登陆
```shell
touch /etc/nologin；
```
####1.2 密码文件用户权限等：
```shell
chmod 644 /etc/passwdchmod 600 /etc/shadowchmod 644 /etc/group
```
####1.3 修改创建文件权限
```shell
umask=027；
```
####1.4 日志等文件信息权限加固
```shell
#只能追加数据
chattr +a /var/log/messages  
#不能被删除 
chattr +i /var/log/messages.* 
chattr +i /etc/shadowchattr 
chattr +i /etc/passwd 
chattr +i /etc/group 
```
####1.5 启动文件权限加固
```shell
#仅仅root可以读，写，执行上述所有script file.
chmod -R 700 /etc/rc.d/init.d/*
```
####1.6 屏蔽登录banner信息
```shell
vi /etc/ssh/sshd_config 
banner NONE
```
####1.7 秘钥增强
```shell
#启用 SHA512 替代 MD5
authconfig --passalgo=sha512 --update 
```
####1.8 限制登录次数
```shell
#登录3次锁定账号2分钟；
vim /etc/pam.d/login
auth required pam_tally2.so deny=3 unlock_time=5 even_deny_root root_unlock_time=120

```
####1.9 限制ssh过期时间
```shell
vim /etc/ssh/sshd_config
#检查响应时间，单位秒
ClientAliveInterval 60
#无响应次数
ClientAliveCountMax 10
```
####1.10)设置Bash保留历史命令的条数
```shell
vi /etc/profile
#修改HISTSIZE=5和HISTFILESIZE=20，即保留最新执行的20条命令。
```
####1.11停止无关的服务,并关闭自启
```shell
/etc/rc.d/init.d/apmd stop
/etc/rc.d/init.d/sendmail stop
/etc/rc.d/init.d/kudzu stop
chkconfig apmd off
chkconfig sendmail off
chkconfig kudzu off
```
####1.12禁用.netrc文件
```shell
touch /.rhosts
chmod 0 /.rhosts
```
####1.13 只允许特定用户使用su命令成为root。
```shell
vim /etc/pam.d/su
auth sufficient /lib/security/pam_rootok.so debug
auth required /lib/security/pam_wheel.so group=wheel

#Red hat 7.0中su文件已做了修改，直接去掉头两行的注释符就可以了
#来将用户admin加入wheel组
[root@deep]# usermod -G10 admin
```
####1.14清楚不必要的系统账户
```shell
[root@deep]# userdel adm
[root@deep]# userdel lp
[root@deep]# userdel sync
[root@deep]# userdel shutdown
[root@deep]# userdel halt
[root@deep]# userdel news
[root@deep]# userdel uucp
[root@deep]# userdel operator
[root@deep]# userdel gopher
#如果不使用 X Window，则删除
[root@deep]# userdel games   
#如果不使用ftp服务则删除 
[root@deep]# userdel ftp     

```
####1.15禁用 Control-Alt-Delete
```shell
vim /etc/inittab
#ca::ctrlaltdel:/sbin/shutdown -t3 -r now

#刷新生效
/sbin/init q
```
####1.16 修正脚本文件在“/etc/rc.d/init.d”目录下的权限
```shell
#对脚本文件的权限进行修正，脚本文件用以决定启动时需要运行的所有正常过程的开启和停止
#只有根用户允许在该目录下使用 Read、Write，和 Execute 脚本文件
chmod -R 700 /etc/rc.d/init.d/*
```

####1.17 去掉不必要的suid程序
```shell
#通过脚本查看
[root@deep]# find / -type f \( -perm -04000 -o -perm -02000 \) \-exec ls –lg {}\;
#通过下面的命令来去掉不需要的程序的‘s’位
[root@deep]# chmod a-s /usr/bin/commandname
```
####1.18重要的配置文件权限更改
```shell
#等设置为0755,并设置为不可更改
chmod 0755 /etc/passwd /etc/shadow /etc/inetd.conf
chattr +i /etc/passwd /etc/shadow /etc/inetd.conf
```
####1.19设置主要文件夹属主是root,并且设置粘滞
```
/etc /usr/etc /bin /usr/bin /sbin /usr/sbin /tmp and/var/tmp
```

####1.20 检查/dev目录
```
/dev目录下不能有特殊文件。
```
####1.21查找任何人可写的文件和目录
```shell
[root@deep]# find / -type f \( -perm -2 -o -perm -20 \) -exec ls -lg {} \;
[root@deep]# find / -type d \( -perm -2 -o -perm -20 \) -exec ls -ldg {} \;
```
####1.21查找异常文件，如..文件，…文件等
```shell
find / -name ".. " -print –xdev
find / -name ".*" -print -xdev | cat -v
```
####1.22检查没有属主的文件。
```shell
find / -nouser -o –nogroup
```
####1.23检查在/dev目录以外还有没有特殊的块文件
```shell
find / \( -type b -o -type c \) -print | grep -v '^/dev/'
```
####1.24备份系统
```shell
#1.备份硬盘
#sync参数来同步I/O
#CONV= NOERROR”，则即使执行过程中有错误，它也会继续复制
dd if=/dev/sda of=/dev/sdb conv=noerror,sync

#2.制作硬盘镜像
dd if=/dev/sda of=~/sdadisk.img

#3用镜像恢复硬盘
dd if=sdadisk.img of=/dev/sda
``