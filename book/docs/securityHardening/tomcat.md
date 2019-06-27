###1. web服务加固

####1.1 隐藏tomcat版本信息
修改conf/server.xml，在Connector节点添加server字段：
![tomcat1.jpg](https://upload-images.jianshu.io/upload_images/7062380-2c2d71871bf8f429.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/800)

####1.2 关闭自动部署：
```
#修改/conf/server.xml 中的 host 字段，
修改 unpackWARs=”false” autoDeploy=”false”；
```
####1.3 自定义错误页面：

修改 web.xml,自定义 40x、50x 等容错页面，防止信息泄露。

####1.4 禁止列目录

修改web.xml false；

####1.5 服务权限控制；

tomcat以非root权限启动，应用部署目录权限和tomcat服务启动用户分离，比如tomcat以tomcat用户启动，而部署应用的目录设置为nobody用户750。

####1.6 启动cookie的httponly，
修改/conf/context.xml，usehttponly=“true”