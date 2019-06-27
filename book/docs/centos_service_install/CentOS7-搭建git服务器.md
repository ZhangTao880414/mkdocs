名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
原因|github毕竟是公开的，而私有仓库又得花钱买。所以我们可以搭建一个私有的，只自己公司使用的。
```
#安装git
yum install git 
#添加git用户，并且设置shell为/usr/bin/git-shell,目的是为了不让git用户远程登陆
useradd -s /usr/bin/git-shell git   
cd /home/git
mkdir .ssh
touch .ssh/authorized_keys
chown -R git.git .ssh
chmod 600 .ssh/authorized_keys
```
######定好存储git仓库的目录，比如 /data/gitroot
```
# 创建一个裸仓库，裸仓库没有工作区，因为服务器上的Git仓库纯粹是为了共享，
#所以不让用户直接登录到服务器上去改工作区，并且服务器上的Git仓库通常都以.git结尾
chown -R git.git sample.git
mkdir /data/gitroot
cd /data/gitroot
git init --bare sample.git 
```

在客户端上（自己pc）克隆远程仓库

以上操作是在git服务器上做的，平时git服务器是不需要开发人员登录修改代码的，它仅仅是充当着一个服务器的角色，就像github一样，平时操作都是在我们自己的pc上做的。

首先要把客户端上的公钥放到git服务器上/home/git/.ssh/authorized_keys文件里

git clone git@ip:/data/gitroot/sample.git

此时就可以在当前目录下生成一个sample的目录，这个就是我们克隆的远程仓库了。进入到这里面，可以开发一些代码，然后push到远程。