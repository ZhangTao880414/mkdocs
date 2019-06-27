###zookeeper简介
```
####0.1 概述
Zookeeper是Hadoop的一个子项目，它是分布式系统中的协调系统，可提供的服务主要有：配置服务、名字服务、分布式同步、组服务等。
####0.2 特点
####0.2.1 简单
Zookeeper的核心是一个精简的文件系统，它支持一些简单的操作和一些抽象操作，例如，排序和通知。

####0.2.2 丰富
Zookeeper的原语操作是很丰富的，可实现一些协调数据结构和协议。例如，分布式队列、分布式锁和一组同级别节点中的“领导者选举”。

####0.2.3 高可靠
Zookeeper支持集群模式，可以很容易的解决单点故障问题。

####0.2.4 松耦合交互
不同进程间的交互不需要了解彼此，甚至可以不必同时存在，某进程在zookeeper中留下消息后，该进程结束后其它进程还可以读这条消息。

####0.2.5 资源库
Zookeeper实现了一个关于通用协调模式的开源共享存储库，能使开发者免于编写这类通用协议。
```
###1.环境准备
| 主机名 | IP |  
|:-:|:-:|  
| kafka01 | 192.168.222.128 |
| kafka02 | 192.168.222.129 |
| kafka03 | 192.168.222.130 |
| 注意 | 构建 Zookeeper 集群的时候，使用的服务器最好是奇数台 |
####1.1设置主机名，并设置hosts

####1.2关闭Selinux、firewalld

####1.3安装JDK

###2安装部署ZooKeeper
####2.1 kafka01上操作
```
#下载ZooKeeper安装包
wget https://mirrors.tuna.tsinghua.edu.cn/apache/zookeeper/stable/zookeeper-3.4.13.tar.gz

#解压并挪到/usr/local/下
tar zxf zookeeper-3.4.13.tar.gz
mv zookeeper-3.4.13 /usr/local/zookeeper

#创建数据、日志存放目录及当前节点ID
cd /usr/local/zookeeper
mkdir data
mkdir dataLog
echo "1" > data/myid

#配置
cp conf/zoo_sample.cfg conf/kafka_zk.cfg

##修改配置文件
vi conf/kafka_zk.cfg
 tickTime=2000
 # 数据文件存放位置
 dataDir=/usr/local/zookeeper/data
 dataLogDir=/usr/local/zookeeper/dataLog
 #服务监听端口
 clientPort=2181
 #选举等待时间
 initLimit=5
 syncLimit=2
 #集群节点信息
 server.1=kafka01:2888:3888
 server.2=kafka02:2888:3888
 server.3=kafka03:2888:3888

```
####2.2分发文件
```
scp -r /usr/local/zookeeper kafka02:/usr/local/
scp -r /usr/local/zookeeper kafka03:/usr/local/
```
####2.3修改id
```
kafka02上，修改/usr/local/zookeeper/data/myid 为2
kafka03上，修改/usr/local/zookeeper/data/myid 为3
```
####2.4添加同步时间的任务计划啊（三台机器都执行）
```
yum install -y ntpdate
echo "*/5 * * * * ntpdate time.windows.com" >> /var/spool/cron/root
```
####2.5集群操作（三台都执行）
```
#启动集群
/usr/local/zookeeper/bin/zkServer.sh start /usr/local/zookeeper/conf/kafka_zk.cfg
#查看集群状态
/usr/local/zookeeper/bin/zkServer.sh status /usr/local/zookeeper/conf/kafka_zk.cfg
 #关闭集群
/usr/local/zookeeper/bin/zkServer.sh stop /usr/local/zookeeper/conf/kafka_zk.cfg
```
###3 测试连接ZooKeeper
```
/usr/local/zookeeper/bin/zkCli.sh -server kafka01:2181
```

