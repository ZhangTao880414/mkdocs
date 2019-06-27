<center><h1>Ansible playbook 安装Nginx</h1></center>  

###1.编辑角色配置文件
[root@centos7 ~]#vim  /root/nginx.yml   
```
- hosts: websrvs
  remote_user: root
  roles:
  - nginx
```
###2.检查文件格式是否合规
```
[root@centos7 ~]#ansible-playbook --syntax-check /root/nginx.yml 
```
###3.安装
```
[root@centos7 ~]#ansible-playbook -C  /root/nginx.yml 
```
###4.编辑Nginx配置文件：
[root@centos7 roles]#vim  nginx/tasks/main.yml  
```
- name: install nginx
  yum: name=nginx state=latest
  when: ansible_os_family ==  "Centos"
```

[root@centos7 roles]#vim /nginx/templates/vhost1.conf.j2 
```
server {
        listen 80;
        server_name {{ ansible_fqdn }};
        location / {
                root "/ngxdata/vhost1";
```
###5.编辑playbook
[root@centos7 roles]#vim  nginx/tasks/main.yml
```
- name: install nginx
  yum: name=nginx state=latest
  when: ansible_os_family ==  "RedHat"
- name: install conf
  template: src=vhost1.conf.j2 dest=/etc/nginx/conf.d/vhost1.conf
  tags: conf
  notify: restart nginx
- name: install site home directory
  file: path={{ ngxroot }} state=directory
- name: install index page
  copy: src=index.html dest={{ ngxroot }}/
- name: start nginx
  service: name=nginx state=started
```
[root@centos7 roles]#vim nginx/handlers/main.yml
```
  - name: restart nginx
  service: name=nginx state=restarted
```

[root@centos7 roles]#vim nginx/vars/main.yml
```
ngxroot: /ngxdata/vhost1  #变量字典不需加- 
```
###6. 测试安装
[root@centos7 playbooks]#ansible-playbook -C  /root/nginx.yml
###7. 安装
[root@centos7 playbooks]#ansible-playbook   /root/nginx.yml