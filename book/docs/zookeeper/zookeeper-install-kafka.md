###1 Kafka集群搭建

zookeeper集群搭建 https://www.jianshu.com/p/6ab2b2cb8f3f
zookeeper常见用法 https://www.jianshu.com/p/29a1792820aa
主机名|IP  
:-:|:-:|  
kafka01|192.168.222.128  
kafka02|192.168.222.129  
kafka03|192.168.222.130  

###2.下载安装包(kafka01操作)
```
#下载安装包
wget https://mirrors.tuna.tsinghua.edu.cn/apache/kafka/2.1.1/kafka_2.11-2.1.1.tgz

#解压并挪到/usr/local(kafka01操作)
tar zxf kafka_2.11-2.1.1.tgz
mv kafka__2.11-2.1.1 /usr/local/kafka

#配置(kafka01操作)
cd /usr/local/kafka
mkdir logs
#按如下方法配置
vim config/server.properties 

 broker.id=1  #当前机器在集群中的唯一标识，和zookeeper的myid性质一样
 port=9092 #当前kafka对外提供服务的端口默认是9092
 host.name=192.168.222.128 #本机IP
 num.network.threads=3 #这个是borker进行网络处理的线程数
 num.io.threads=8 #这个是borker进行I/O处理的线程数
 log.dirs=/usr/local/kafka/logs #消息存放的目录，这个目录可以配置为“，”逗号分割的表达式，上面的num.io.threads要大于这个目录的个数这个目录，如果配置多个目录，新创建的topic他把消息持久化的地方是，当前以逗号分割的目录中，那个分区数最少就放那一个
 socket.send.buffer.bytes=102400 #发送缓冲区buffer大小，数据不是一下子就发送的，先回存储到缓冲区了到达一定的大小后在发送，能提高性能
 socket.receive.buffer.bytes=102400 #kafka接收缓冲区大小，当数据到达一定大小后在序列化到磁盘
 socket.request.max.bytes=104857600 #这个参数是向kafka请求消息或者向kafka发送消息的请请求的最大数，这个值不能超过java的堆栈大小
 num.partitions=1 #默认的分区数，一个topic默认1个分区数
 log.retention.hours=168 #默认消息的最大持久化时间，168小时，7天
 message.max.byte=5242880  #消息保存的最大值5M
 default.replication.factor=2  #kafka保存消息的副本数，如果一个副本失效了，另一个还可以继续提供服务
 replica.fetch.max.bytes=5242880  #取消息的最大直接数
 log.segment.bytes=1073741824 #这个参数是：因为kafka的消息是以追加的形式落地到文件，当超过这个值的时候，kafka会新起一个文件
 log.retention.check.interval.ms=300000 #每隔300000毫秒去检查上面配置的log失效时间（log.retention.hours=168 ），到目录查看是否有过期的消息如果有，删除
 log.cleaner.enable=false #是否启用log压缩，一般不用启用，启用的话可以提高性能
 zookeeper.connect=aming01:2181,aming02:2181,aming03:2181 #设置zookeeper的连接端口

```
###3 分发到另外两台机器(kafka01操作)
```
scp -r /usr/local/kafka kafka02:/usr/local/

scp -r /usr/local/kafka kafka03:/usr/local/
```
###4 修改配置文件
```
#kafka02;将brokerid设置为2，host.name 设置为192.168.222.129
vim config/server.propertie

#kafka03; 将brokerid设置为3，host.name 设置为192.168.222.130
vim config/server.propertie
```
###5 启动服务(三台都操作)
```
/usr/local/kafka/bin/kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties

```
###6 测试
kafka01作为生产者，kafka03作为消费者

####6.1 在kafka01上执行：
```
#创建一个主题test：一个分区，两个副本
/usr/local/kafka/bin/kafka-topics.sh --create --zookeeper kafka01:2181 --replication-factor 2 --partitions 1 --topic test   

#创建一个生产者（消息发布者）
/usr/local/kafka/bin/kafka-console-producer.sh --broker-list kafka01:9092 --topic test
#此时会进入到新的console（以>开头）
```
####6.2 在kafka03上执行
```
#创建一个消费者（消息订阅者）
/usr/local/kafka/bin/kafka-console-consumer.sh --bootstrap-server aming01:9092  --topic test --from-beginning

#此时也会进入到另外一个console下
#再到kafka01上的> 下输入一些字符，然后kafka03上就可以看到了。

```

###7常用命令
####7.1查看主题
```
/usr/local/kafka/bin/kafka-topics.sh --list --zookeeper localhost:2181

```
####7.2查看主题详情
```
/usr/local/kafka/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic test

```
####7.3删除主题(需设置参数delete.topic.enable=true)
```
/usr/local/kafka/bin/kafka-topics.sh --zookeeper localhost:2181 --delete --topic test

```
####7.4生产者参数查看
```
/usr/local/kafka/bin/kafka-console-producer.sh

```
####7.5消费者参数查看
```
/usr/local/kafka/bin/kafka-console-consumer.sh

```