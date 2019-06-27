<center><h1>常用模块</h1></center>  

###1 group
```
#group 参数
[root@centos7 ansible]#ansible-doc -s group  
- name: Add or remove groups
  action: group
      gid                        # 组gid      
      name=                  # Name 组名.
      state                     # present ：创建  absent :删除
      system                 #默认系统组no，

#创建组：
[root@centos7 ansible]#ansible all -m group -a "gid=3000 name=mygrp state=present system=no"
192.168.18.98 | SUCCESS => {
    "changed": true, 
    "gid": 3000, 
    "name": "mygrp", 
    "state": "present", 
    "system": false
}

#192.168.18.97主机上查看
[root@centos7 ~]#tail -1 /etc/group
mygrp:x:3000:

#删除组：
[root@centos7 ansible]#ansible all -m group -a "gid=3000 name=mygrp state=absent" 
```
###2 user
```
#user 参数
[root@centos7 ansible]#ansible-doc -s user
name=       #名字
comment：      #注释信息
expires     #过期时间
group              #基本组
groups      #附加组
home        #家目录路径
move_home   #原来家目录及文件是否移动过来
passwd              #定义密码
shell       #选择shell
state       # 创建
system      #系统用户
uid                 #uid

#创建用户
[root@centos7 ansible]#ansible all -m user -a"uid=5000 name=testuser state=present groups=mygrp shell=/bin/tcsh" #创建用户
192.168.18.98 | SUCCESS => {
    "changed": true, 
    "comment": "", 
    "createhome": true, 
    "group": 5000, 
    "groups": "mygrp", 
    "home": "/home/testuser", 
    "name": "testuser", 
    "shell": "/bin/bash", 
    "state": "present", 
    "system": false, 
    "uid": 5000
}

#删除用户
ansible all -m user -a "name=testuser  state=absent"
```

###3 copy:
```
#copy 参数
[root@centos7 ansible]#ansible-doc -s copy 

dest=   #目标路径
src    #源 路径  是目录：做递归 如果带/复制目录里面内容，不带/复制目录和文件
mode  #权限
content   #生成文件

#简单复制文件
[root@centos7 ~]#ansible all -m copy -a "src=/etc/fstab dest=/tmp/fstab.ansible mode=600"

#只复制里面内容
[root@centos7 ~]#ansible all -m copy -a "src=/etc/pam.d/ dest=/tmp/"

#复制目录及内容
[root@centos7 ~]#ansible all -m copy -a "src=/etc/pam.d dest=/tmp/"  

#复制目录及内容
[root@centos7 ~]#ansible all -m copy -a "content='hi there' dest=/tmp/ansib.txt"

#复制目录及内容并改属主属组
[root@centos7 ~]#ansible all -m copy -a "content='hi there' dest=/tmp/ansib.txt owner=testuser group=mygrp"     
```
###4 command 
```
##command 参数
[root@centos7 ~]#ansible-doc -s command  
 chdir    #切换目录执行
 executable  #不适应默认shell使用此项
 free_form=   #自由格式执行

#使用命令ifconfig
[root@centos7 ~]#ansible all -m command -a "ifconfig"  

#创建一个目录
[root@centos7 ~]#ansible all -m command -a "chdir=/var/tmp mkdir hi.dir"  

#设置用户密码
[root@centos7 ~]#ansible all -m command -a "echo 'hello' |passwd --stdin testuser" 
    192.168.18.97 | SUCCESS | rc=0 >>
    hello |passwd --stdin testuser

#做命令行展开，使用shell命令
[root@centos7 ~]#ansible all -m shell -a "echo jie |passwd --stdin testuser"  
192.168.18.98 | SUCCESS | rc=0 >>
Changing password for user testuser.
passwd: all authentication tokens updated successfully.
```
###5 file
```
#file 参数
[root@centos7 ~]#ansible-doc -s file 
path=  #目标路径
start  #创建文件   directory目录   file 文件 
src  #符号链接
mode  #属主属组

#目录不存在创建
[root@centos7 ~]#ansible all -m file -a "path=/var/tmp/hello.dir state=directory" 

#创建连接
[root@centos7 ~]#ansible all -m file -a "src=/var/tmp/fstab.ansible path=/var/tmp/fstable.link  state=link"  
```
###6 cron
```
#cron 参数
[root@centos7 ~]#ansible-doc -s cron 
day #天
hour #小时
job  #任务
name  #任务名称
state   #present 添加 absent 删除

#创建任务 同步时间
[root@centos7 ~]#ansible all -m cron -a "minute=*/3 job='usr/sbin/update 172.16.0.1 &> /dev/nul' name=renwu" 

#client 主机查看任务
[root@centos7 tmp]#crontab -l
#Ansible: renwu
*/3 * * * * usr/sbin/update 172.16.0.1 &> /dev/nul

#删除任务 注意如果创建时没有写上name时，删除带上name=None
[root@centos7 ~]#ansible all -m cron -a "minute=*/3 job='usr/sbin/update 172.16.0.1 &> /dev/nul' name=renwu state=absent" 
```
###7 yum 
```
#yum c参数
[root@centos7 ~]#ansible-doc -s yum  
state   #安装（ present或installed或latest)  卸载（absent或removed）
disablerepo #禁用某个仓库
enablerepo #启用某个仓库
disable_gpg_check #禁用gpg检测

#安装nginx程序
[root@centos7 ~]#ansible all -m yum -a "name=nginx state=installed"  
```

###8 service
```
#service 参数
[root@centos7 ~]#ansible-doc -s service  
 enabled #开机启用
 name=  #服务名称
 pattern  #过滤字符
 runlevel #哪个级别启用
 state # started 启动 stopped停止  restarted 重启 reloaded重载
 
 #启动nginx服务
 [root@centos7 ~]#ansible all -m service -a "name=nginx state=started"  
 #服务nginx停止
 [root@centos7 ~]#ansible all -m service -a "name=nginx state=stopped" 
```

###9 script
```
#script 参数
 [root@centos7 ~]#ansible-doc -s  script

 #写一个脚本
 [root@centos7 ~]#vim  /tmp/test.sh 
    #!/bin/bash
    echo "test script"  > /tmp/1.txt

#执行脚本
 [root@centos7 ~]#ansible all -m script -a "/tmp/test.sh"
```