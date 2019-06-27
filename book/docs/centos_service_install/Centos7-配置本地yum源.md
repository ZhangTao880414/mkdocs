名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 

```
#查看yum源
ls /etc/yum.repos.d/
CentOS-Base.repo  CentOS-CR.repo  CentOS-Debuginfo.repo  CentOS-fasttrack.repo  CentOS-Media.repo  CentOS-Sources.repo  CentOS-Vault.repo
#删除原有基础yum源，重命名使之失效
mv /etc/yum.repos.d/CentOS-Base.repo  /etc/yum.repos.d/CentOS-Base.repo.bak

#创建本地yum文件夹,并挂在镜像
mkdir  /mnt/cdrom
mount /dev/cdrom /mnt/cdrom

#编辑与yum源，并修改如下
vim /etc/yum.repos.d/CentOS-Media.repo
----------------------------------------------------
[c7-media]
name=CentOS-$releasever - Media
baseurl=file:///mnt/cdrom
#        file:///media/cdrom/
#       file:///media/cdrecorder/
gpgcheck=1
enabled=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
----------------------------------------------------

#清除缓存并更新
yum clean all
yum makecache
yum update
```
