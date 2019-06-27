名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
master IP|192.168.199.130
node IP|1992.168.199.131

node执行：
```
mkdir -p ~/.ssh
```

master执行：
```
ssh-keygen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
scp ~/.ssh/authorized_keys root@192.168.199.131:~/.ssh/
```