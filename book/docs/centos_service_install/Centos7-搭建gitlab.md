名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
gitlab|gitlab-ce-11.6.2
gitlab server ip|192.168.199.40
user client ip|192.168.199.44

#####gitlab安装:官网地址 https://about.gitlab.com/installation/
```
#下载地址
https://packages.gitlab.com/gitlab/gitlab-ce/

#配置gitlab yum源
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash

#安装
yum install -y gitlab-ce-11.6.2-ce.0.el7.x86_64

#编辑配置文件gitlab.rb，修改external_url为主机host或者ip
vim /etc/gitlab/gitlab.rb
external_url 'http://192.168.199.40'

#执行配置
sudo gitlab-ctl reconfigure

```
#####浏览器访问 ip，第一次需要设置密码，我在这里设置为redhat12345，登录时用户为root
![image.png](https://upload-images.jianshu.io/upload_images/7062380-d1b3c53521d96a62.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

######创建hellogitlab项目
![image.png](https://upload-images.jianshu.io/upload_images/7062380-77cd1439c1a973fd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

#server添加client 的ssh key：settings -> ssh keys
![settings.png](https://upload-images.jianshu.io/upload_images/7062380-75735b059b5456e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![ssh key.png](https://upload-images.jianshu.io/upload_images/7062380-bce9160f1cb60087.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)


######client机器 ssh key 创建
```
#创建ssh key
ssh-keygen -N ""
#查看公钥
cat /root/.ssh/id_rsa.pub

```

#####client 192.168.199.44 机器下载项目
```
git clone git@192.168.199.40:root/hellogitlab.git

#client设置user.name，user.email为自己设置的用户，邮箱
git config --global user.name "test"
git config --global user.email "test@example.com"
git config --global push.default matching
git config --global push.default simple

#创建测试文件
vim index.html
hellogitlab

#添加提交文件
git add index.html
#添加提交备注
git commit -a -m "add index.html"
#提交
git push

```
######提交后在 gitlab中可以查看到
![image.png](https://upload-images.jianshu.io/upload_images/7062380-e44d9c2ab41ebbdb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

更多git 使用命令使用详细请见：https://www.jianshu.com/p/3928b011dd18