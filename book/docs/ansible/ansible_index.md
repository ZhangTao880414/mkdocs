###1. 简介：
Ansible:—基于 Python paramiko 开发，分布式，无需客户端，轻量级，配置语法使用 YMAL 及 Jinja2模板语言，更强的远程命令执行操作
安装配置只需要在sever端即可，client客户端只要与server端建立密钥连接即可

###2. 环境
名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
Anslble|2.7.10
Service IP| 192.168.199.40 
Client IP| 192.168.18.98


###3. 192.168.199.40 安装

```
yum install -y ansible
```

###4. 远程主机密钥连接

```
#1. 192.168.199.40 创建密钥
ssh-keygen -t rsa -P ""

#2. 传递给后端目标主机
ssh-copy-id -i ~/.ssh/id_rsa.pub root@192.168.199.41
```

###5. 编辑配置文件
```
#192.168.199.40  编辑添加ansible的hosts

vim /etc/ansible/hosts
#添加1个后端web服务主机
[webser]
192.168.18.98 

# 探测是否能通
#这里的all是定义的所有主机，也可以写自己在hosts的组名websrv
[root@centos7 ansible]# ansible all -m ping     
192.168.18.98  | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```
### 6. 命令参数
```
#常用命令的介绍
[root@centos7 ansible]#ansible --help   
  -v,–verbose    # 详细模式，如果命令执行成功，输出详细的结果(-vv –vvv -vvvv)
  -i PATH,–inventory=PATH  #指定host文件的路径，默认是/etc/ansible/hosts
  -f NUM,–forks=NUM     # NUM是指定一个整数，默认是5，指定fork开启同步进程的个数。
  -m NAME,–module-name=NAME  #指定使用的module名称，默认是command
  -m DIRECTORY,–module-path=DIRECTORY #指定module的目录来加载module，默认是/usr/share/ansible,
  -a,MODULE_ARGS   #指定module模块的参数
  -k,–ask-pass        # 提示输入ssh的密码，而不是使用基于ssh的密钥认证
  –sudo             #  指定使用sudo获得root权限
  -K,–ask-sudo-pass      #提示输入sudo密码，与–sudo一起使用
  -u USERNAME,–user=USERNAME # 指定移动端的执行用户
  -C,–check                #测试此命令执行会改变什么内容，不会真正的去执行
```


