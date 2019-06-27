名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
###1.问题：
SSH连接超时被远程主机中断

###2，解决办法：
####2.1修改目标主机sshd_config
```
vi /etc/ssh/sshd_config
#添加 两行
ClientAliveInterval 600
ClientAliveCountMax 10

#ClientAliveInterval 单位秒，指定了服务器端向客户端请求消息的时间间隔, 默认是0，不发送，修改为600，表示10分钟发送一次。 
#每一分钟，sshd都和ssh client打个招呼，检测它是否存在，不存时即断开连接。
#ClientAliveCountMax，设置允许超时的次数，比如10，如果发现客户端没有相应，则判断一次超时


#配置生效
service sshd reload

```
####2.2 修改目标主机系统TMOUT时间
```
vi /etc/profile
#增加一行（600秒）
#TMOUT=0表示永不断开，一般不这样做
export TMOUT=600
#配置生效
source /etc/profile
```
####2.3 修改client主机ssh_config
```
vi /etc/ssh/ssh_config
#增加一行(600秒),设置client主机响应时间。
ServerAliveInterval 600

#配置生效
source /etc/profile
```