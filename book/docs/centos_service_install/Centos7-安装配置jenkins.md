名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
Jenkins|2.173-1.1
java jdk|11.0.3+12-LTS

######安装Jenkins 
```
#安装java jdk，lts版本，需要注册
#java jdk rpm包下载地址：http://www.oracle.com/technetwork/java/javase/downloads/jdk8- downloads-2133151.html
#注意centos下不可以安装成`gcj`(GNU Compiler for the Java Programing Language),需要卸载，安装其他版本
#详细bug：https://issues.jenkins-ci.org/browse/JENKINS-743

#查看java jdk版本
java -version
#如果版本不对，先卸载
yum remove java

#安装桌面，并启动桌面 ，不然jenkins会报错“AWT is not properly configured on this server”
yum groupinstall -y "GNOME Desktop"
init 5

#下载文件jenkins.repo
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo

#导入公钥
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

#安装jenkins
yum install -y jenkins

#更新jenkins
yum update jenkins

#启动jenkins ，并配置开机启动
systemctl start jenkins
chkconfig jenkins on

#查看8080
netstat -ntulp | grep 8080

#卸载jenkins
rpm -e jenkins
#会有一些残留的文件分散在各地
find / -iname jenkins | xargs -n 1000 rm -rf

```
######访问 ip:8080
######获取管理员密码，登录 cat /var/lib/jenkins/secrets/initialAdminPassword

![登录.png](https://upload-images.jianshu.io/upload_images/7062380-ff5b3488732273af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![安装插件.png](https://upload-images.jianshu.io/upload_images/7062380-915fb0dc32550449.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![插件安装中.png](https://upload-images.jianshu.io/upload_images/7062380-51c984156a929698.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![创建用户.png](https://upload-images.jianshu.io/upload_images/7062380-cf0b28e48e18afd2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![首页界面.png](https://upload-images.jianshu.io/upload_images/7062380-63594099ed131738.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![创建任务.png](https://upload-images.jianshu.io/upload_images/7062380-b2c363988fe52a3b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![设置流水线.png](https://upload-images.jianshu.io/upload_images/7062380-6fc2974b7c6ead8a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

![查看.png](https://upload-images.jianshu.io/upload_images/7062380-be9b5564ec24c74a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/720)

