<center><h1>Gitlab 常用</h1></center>

### 2.2 查看日志

```
root@k8s4:/etc/gitlab# gitlab-ctl tail
```

### 2.3 日志路径
```
root@k8s4:/etc/gitlab# cd /var/log/gitlab/
```

### 2.4 gitlab数据
```
root@k8s4:/var/log/gitlab# ls /var/opt/gitlab/
```

### 2.5 gitlab备份数据
```
root@k8s4:/# sudo gitlab-rake gitlab:backup:create
/var/opt/gitlab/backups 下生成备份后的文件1900504139_2019_05_04_gitlab_backup.tar
```

### 2.6 gitlab备份恢复
```
#1.将备份文件拷贝到/var/opt/gitlab/backups下

#2.停止相关数据连接服务
sudo gitlab-ctl stop unicorn
sudo gitlab-ctl stop sidekiq

#3.从指定时间戳的备份恢复（backups目录下有多个备份文件时）：
root@k8s4:/var/opt/gitlab/backups/#  sudo gitlab-rake gitlab:backup:restore BACKUP=1900504139

从默认备份恢复（backups目录下只有一个备份文件时）：
sudo gitlab-rake gitlab:backup:restore

#4.启动Gitlab
sudo gitlab-ctl start
sudo gitlab-ctl reconfigure

#5.注意：恢复数据时，提示版本不匹配，卸载、指定版本重装后出现500或502错误，是卸载不彻底引起
#完整的卸载方法如下：
sudo gitlab-ctl stop
sudo apt-get --purge remove gitlab-ce
sudo rm -r /var/opt/gitlab
sudo rm -r /opt/gitlab
sudo rm -r /etc/gitlab


```
### 2.7 gitlab修改默认备份目录
```
vim /etc/gitlab/gitlab.rb
gitlab_rails['backup_path'] = '/home/backup'

#重载配置文件
gitlab-ctl reconfigure

```
