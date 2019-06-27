名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
```
#配置阿里云yum源
yum install -y wget
cd  /etc/yum.repos.d/
mv  CentOS-Base.repo CentOS-Base.repo.bak
wget  http://mirrors.aliyun.com/repo/Centos-7.repo
mv Centos-7.repo CentOS-Base.repo
#配置epel源
wget https://mirrors.aliyun.com/repo/epel-7.repo
#清除缓存并更新
yum clean all
yum makecache
yum update
```