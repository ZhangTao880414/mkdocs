
<center><h1> Ansible Playbook</h1></center>  

###1 介绍
Playbooks 是 一个不同于使用Ansible命令行执行方式的模式，其功能更强大灵活。简单来说，playbook是一个非常简单的配置管理和多主机部署系统，不同于任何已经存在的模式，可作为一个适合部署复杂应用程序的基础。Playbook可以定制配置，可以按照指定的操作步骤有序执行，支持同步和异步方式。值得注意的是playbook是通过YAML格式来进行描述定义的。

###2 语法：
使用yaml用法，可参考维基百科 或官网文档http://docs.ansible.com/ansible/latest/YAMLSyntax.html

###3 核心元素：
```
Hosts：主机
Tasks：任务列表
Variables:变量
Templates：包含了模板语法的文本文件；
Handlers：由特定条件触发的任务；
```
###4 创建playbook
```
#创建剧本
[root@centos7 ansible]#mkdir playbooks 
[root@centos7 ansible]#cd playbooks 
[root@centos7 playbooks]#vim  1.yaml 
    - host: 192.168.18.97
      remote_user: root
      tasks:
      - name: install redis
        yum: name=redis state=latest
      - name: start redis
        service: name=redis state=started

#语法检查
[root@centos7 playbooks]#ansible-playbook --syntax-check  1.yaml   
#测试安装
[root@centos7 playbooks]#ansible-playbook -C 1.yaml   
```
###5 对配置文件的修改
```
#使用已有的配置配置redis.conf 部署redis
[root@centos7 playbooks]#vim 1.yaml
- hosts: all
  remote_user: root
  tasks:
  - name: install redis
    yum: name=redis state=latest
  - name: copy config file
    copy: src=/root/playbooks/redis.conf dest=/etc/redis.conf owner=redis
  - name: start redis
    service: name=redis state=started
#检查语法
[root@centos7 playbooks]#ansible-playbook --syntax-check  1.yaml 
#测试安装
[root@centos7 playbooks]#ansible-playbook -C  1.yaml 
#安装
[root@centos7 playbooks]#ansible-playbook   1.yaml
````````
###6 标签功能介绍
#####6.1 handlers
handlers：
任务，在特定条件下触发；
接收到其它任务的通知时被触发；
notify: HANDLER TASK NAME
```
[root@centos7 playbooks]#cp 1.yaml 2.yaml
[root@centos7 playbooks]#vim 2.yaml 
    - hosts: all
      remote_user: root
      tasks:
      - name: install redis
        yum: name=redis state=latest
      - name: copy config file
        copy: src=/root/playbooks/redis.conf dest=/etc/redis.conf owner=redis
        notify: restart redis  
      - name: start redis
        service: name=redis state=started
     handlers:  #接收到其它任务的通知时被触发；
      - name: restart redis
        service: name=redis stat=restarted
[root@centos7 playbooks]#ansible-playbook --syntax-check  2.yaml 
[root@centos7 playbooks]#ansible-playbook -C  2.yaml 
[root@centos7 playbooks]#ansible-playbook   2.yaml 
#改变的配置文件，触发重启服务
```
#####6.2 tags
做标签:只对有标签项作出操作,则可继续修改
```
[root@centos7 playbooks]#vim 2.yaml
- hosts: all
  remote_user: root
  tasks:
  - name: install redis
    yum: name=redis state=latest
  - name: copy config file
    copy: src=/root/playbooks/redis.conf dest=/etc/redis.conf owner=redis
    notify: restart redis
    tags: configfile
  - name: start redis
    service: name=redis state=started
  handlers:
  - name: restart redis
    service: name=redis state=restarted
[root@centos7 playbooks]#ansible-playbook --syntax-check  2.yaml 
[root@centos7 playbooks]#ansible-playbook -C  2.yaml 
[root@centos7 playbooks]#ansible-playbook   -t configfile 2.yaml  #对标签操作
```

#####6.3 variables
(1) facts：可直接调用；
 注意：可使用setup模块直接获取目标主机的facters；
(2) 用户自定义变量：
    (a) ansible-playbook命令的命令行中的
        -e VARS, --extra-vars=VARS                      
    (b) 在playbook中定义变量的方法：
          vars:
            - var1: value1
            - var2: value2
          变量引用：{{ variable }}
(3) 通过roles传递变量；
(4) Host Inventory
    (a) 用户自定义变量
        (i) 向不同的主机传递不同的变量；
            IP/HOSTNAME  varaiable=value var2=value2
        (ii) 向组中的主机传递相同的变量；
            [groupname:vars]
            variable=value
    (b) invertory参数
        用于定义ansible远程连接目标主机时使用的参数，而非传递给playbook的变量；
            ansible_ssh_host
            ansible_ssh_port
            ansible_ssh_user
            ansible_ssh_pass
            ansbile_sudo_pass
            ...

#####6.4 templates
文本文件，嵌套有脚本（使用模板编程语言编写）
Jinja2：
字面量：
字符串：使用单引号或双引号；
数字：整数，浮点数；
列表：[item1, item2, ...]
元组：(item1, item2, ...)
字典：{key1:value1, key2:value2, ...}
布尔型：true/false
算术运算：
+, -, *, /, //, %, **
比较操作：
==, !=, >, >=, <, <=
逻辑运算：
and, or, not

例1.
模板配置文件 ：
```
nginx.conf.j2
       worker_processes {{ ansible_processor_vcpus }};
         listen {{ http_port }};

- hosts: websrvs
  remote_user: root
  tasks:
   - name: install nginx
     yum: name=nginx state=present
   - name: install conf file
     template: src=files/nginx.conf.j2 dest=/etc/nginx/nginx.conf
     notify: restart nginx
     tags: instconf
   - name: start nginx service
     service: name=nginx state=started
    handlers:
      - name: restart nginx
       service: name=nginx state=restarted
```
例2
模板配置文件 ：
cp  /root/playbook/redis.conf{,.j2}
vim /etc/playbook/redis.conf.j2
```
bind {{ ansible_ens33.ipv4.address }} //调用网卡

- hosts: all 
  remote_user: root
  tasks:
  - name: install config file 
    template: src=/root/playbooks/redis.conf.j2 dest=/tmp/redis.conf
```
####6.5 条件测试和循环
```
[root@centos7 playbooks]#vim os.yaml
- hosts: websrvs
  remote_user: root
  tasks:
  - name: install httpd
    yum: name=httpd state=latest
    when: ansible_os_family ==  "RedHat"
  - name: install apache2
    apt: name=apache2 state=latest
    when: ansible_os_family ==  "Debian"
 [root@centos7 playbooks]#ansible-playbook --syntax-check os.yaml
迭代安装：
[root@centos7 playbooks]#vim 8.yaml
- hosts: websrvs
  remote_user: root
  tasks:
  - name: install {{ item }} package
    yum: name={{ item }} state=latest
    with_items:
    - nginx
    - tomcat
    - mariadb-server
    - redis
[root@centos7 playbooks]#ansible-playbook --syntax-check 8.yaml
[root@centos7 playbooks]#ansible-playbook -C 8.yaml
```
#####16.6 角色(roles)
每个角色，以特定的层级目录结构进行组织：
如：nginx/
      files/ ：存放由copy或script模块等调用的文件；
      templates/：template模块查找所需要模板文件的目录；
      tasks/：至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含；
      handlers/：至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含；
      vars/：至少应该包含一个名为main.yml的文件；其它的文件需要在此文件中通过include进行包含；
      meta/：至少应该包含一个名为main.yml的文件，定义当前角色的特殊设定及其依赖关系；其它的文件需要在此文件中通过include进行包含；
      default/：设定默认变量时使用此目录中的main.yml文件；

在playbook调用角色方法1：
- hosts: websrvs
  remote_user: root
  roles:
  - mysql
  - memcached
  - nginx

在playbook调用角色方法2：传递变量给角```
- hosts: 
  remote_user: root
  roles:
  - { role: nginx, username: nginx }
键role用于指定角色名称；后续的k/v用于传递变量给角色；