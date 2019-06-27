名称|版本
:-:|:-:|
软件下载| [https://github.com/jumpserver/jumpserver](https://github.com/jumpserver/jumpserver)
系统平台| centos 7.6
python|3.5.4
具体功能| [www.jumpserver.org](http://www.jumpserver.org/)

###1、关闭防火墙以及selinux 
```
#参考：https://www.jianshu.com/p/42bc9d94d2e4
#关闭防火墙
systemctl stop firewalld.service
#禁止firewall开机启动
systemctl disable firewalld.service 
#临时关闭selinux
setenforce 0

vi /etc/selinux/config
#修改 SELINUX=enforcing为SELINUX=disabled
```
###2、配置阿里yum源
```
参考：https://www.jianshu.com/p/4c05fb9843bf
```
###3、安装jump-server所要依赖的包 不要落下包
```
yum -y install git python-pip mysql-devel gcc automake autoconf python-devel vim sshpass readline-devel gcc-c++
yum -y install libtiff-devel libjpeg-devel libzip-devel freetype-devel lcms2-devel libwebp-devel tcl-devel tk-devel sshpass openldap-devel

```
###4、下载软件包以及软件包升级
####4.1.下载软件包
```
[root@test1download]#git clone https://github.com/jumpserver/jumpserver.git
[root@test1 requirements]# cd /download/jumpserver/jumpserver-dev/requirements
```

####4.2.升级python and pip
```
#升级python至3.5.4
#方法参考 https://www.jianshu.com/p/97f1c632d018
cd /download
wget https://www.python.org/ftp/python/3.5.4/Python-3.5.4.tgz
tar -zxvf Python-3.5.4.tgz
cd Python-3.5.4
./configure --enable-optimizations --enable-shared 
make&&make install
mv /usr/bin/python /usr/bin/python2.6
ln -sv /usr/local/bin/python3.5 /usr/bin/python
python -V

#修改yum ， 将文件头修改为：#!/usr/bin/python2.6
vim /usr/bin/yum
vim /usr/libexec/urlgrabber-ext-down

#添加环境变量
vi /etc/profile
export  PATH="$PATH:/usr/local/python3.5/bin/"
#刷新生效
source /etc/profile

#升级pip
wget https://bootstrap.pypa.io/get-pip.py 
sudo python get-pip.py
pip install --upgrade pip
```
####4.3.安装MySQL-python
```
yum list all MySQL-python
```
####4.4: 安装依赖 
```
pip install pipreqs
```
####4.5：安装其他依赖包
```
pip install -r requirements.txt
```
###5、准备配置文件
```
cd /download/jumpserver
cp config_example.py config.py

vim config.py
#默认使用的是 DevelpmentConfig 所以应该去修改这部分  可以不用改这里是邮件 
class DevelopmentConfig(Config):
        EMAIL_HOST = 'smtp.exmail.qq.com'
        EMAIL_PORT = 465
        EMAIL_HOST_USER = 'ask@jumpserver.org'
        EMAIL_HOST_PASSWORD = 'xxx'
        EMAIL_USE_SSL = True   // 端口是 465 设置 True 否则 False
        EMAIL_USE_TLS = False  // 端口是 587 设置为 True 否则 False
        SITE_URL = 'http://localhost:8080'  // 发送邮件会使用这个地址
```
###6、初始化数据库
```
cd utils
sh make_migrations.sh
sh init_db.sh
```
###7、安装redis server
```
yum -y install redis
service redis start
```
###8、启动    建议用nohup直接启动 就不用前台启动了
```
nohup python run_server.py >output 2>&1 &
```
访问  http://ip:8080
账号密码： admin admin

###9、效果图
![jumpserver.png](https://upload-images.jianshu.io/upload_images/7062380-83d1c843d8447a3c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)
