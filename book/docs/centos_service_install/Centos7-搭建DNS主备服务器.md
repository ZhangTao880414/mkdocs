名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
DNS master server|192.168.199.102
DNS slave  server|192.168.199.103

#DNS master server 192.168.199.102配置：
```
#安装相关软件
yum -y install bind bind-utils bind-chroot net-tools

#named.conf修改配置如下
cp -p /etc/named.conf /etc/named.conf.bak
vim /etc/named.conf 
listen-on port 53 { any; };
allow-query     { any; };
allow-transfer     { 192.168.199.103; };
alsp-notify     { 192.168.199.103; };
notify     yes;

#编辑域空间配置文件，增加以下内容
#dnsserver.com  为自己设置的域名。可自定义修改为自己的
#type master 为DNS服务类型，默认为master，这里我们是搭建的第一个DNS服务器，则就定为主服务器，即默认的master
#dnsserver.com.zone 为域名正向解析配置文件名 ，这个文件要在以下目录配置 /var/named/chroot/var/named/
#allow-transter 允许指定备机拉去zone文件
#allow-notify 通知主机向备机进行同步更新
#notify      一有更新便主动通知备机更新

vim /etc/named.rfc1912.zones 
#正向解析内容
zone "dnsserver.com" IN {
        type master;
        file "dnsserver.com.zone";
        allow-transfer     { 192.168.199.103; };
        also-notify     { 192.168.199.103; };
        notify     yes;
};
#反向解析内容
zone "199.168.192.in-addr.arpa" IN {
        type master;
        file "199.168.192.in-addr.arpa";
        allow-transfer     { 192.168.199.103; };
        also-notify     { 192.168.199.103; };
        notify     yes;
};

#配置正向解析文件,增加两条解析，
#注：每次修改完主DNS配置后，都需要改一下serial序列号，且必须比从服务器号大，一般为年月日20190407
cp -p /var/named/named.localhost  /var/named/dnsserver.com.zone
vim /var/named/dnsserver.com.zone
$TTL 1D
@	IN SOA	@ rname.invalid. (
					20190407	; serial
					1D	; refresh
					1H	; retry
					1W	; expire
					3H )	; minimum
	NS	@
	A	127.0.0.1	
	A	192.168.199.102
	AAAA	::1
nginx01	A	192.168.199.100
nginx02	A	192.168.199.101

#配置反向解析文件（文件名ip钱前三位反着写）
cp -p /var/named/named.localhost  /var/named/199.168.192.in-addr.arpa
vim /var/named/199.168.192.in-addr.arpa
$TTL 1D
@       IN SOA  @ rname.invalid. (
                                        20190407       ; serial
                                        1D      ; refresh
                                        1H      ; retry
                                        1W      ; expire
                                        3H )    ; minimum
        NS      @
        A       127.0.0.1
        AAAA    ::1
100     PTR     nginx01.dnsserver.com
101     PTR     nginx02.dnsserver.com


#检测配置语法是否有误,无输出表示正确
named-checkconf /etc/named.conf

#启动服务
systemctl start named.service
#配置开机自启
systemctl enable named.service
#关闭服务
systemctl stop named.service


#查看服务是否启动
ps -eaf |grep named

#查看53端口是否监听
netstat -an |grep :53

#防火墙放行53端口
iptables -I INPUT -p tcp --dport 53 -j ACCEPT
iptables -I INPUT -p udp --dport 53 -j ACCEPT

#测试是否成功，返回数据无异常即可
dig www.baidu.com @192.168.199.102

```

#DNS slave server ：192.168.199.103 配置
```
#安装相关软件
yum -y install bind bind-utils bind-chroot net-tools

#修改备机DNS配置文件
vim /etc/named.rfc1912.zones 
#正向解析配置
zone "dnsserver.com.zone" IN {
        type slave;
        file "slaves/dnsserver.com.zone";
        Masters     { 192.168.199.102; };
        allow-transfer     { 192.168.199.102; };
        also-notify     { 192.168.199.102; };
        notify     yes;
};
#反向解析配置
zone "199.168.192.in-addr.arpa" IN {
        type slave;
        file "slaves/199.168.192.in-addr.arpa";
        Masters     { 192.168.199.102; };
        allow-transfer     { 192.168.199.102; };
        also-notify     { 192.168.199.102; };
        notify     yes;
};

#检测配置语法是否有误,无输出表示正确
named-checkconf /etc/named.conf

#重新启动服务
systemctl restart named.service
```
#检查主备同步情况
查看/var/named/slaves/dnsserver.com.zone 配置文件是否同步
查看/var/named/slaves/199.168.192.in-addr.arpa 配置文件是否同步

#验证DNS配置情况
######反向解析
```
[root@dns-server named]# nslookup 192.168.199.100
Server:		192.168.199.102
Address:	192.168.199.102#53

100.199.168.192.in-addr.arpa	name = nginx01.dnsserver.com.199.168.192.in-addr.arpa.

```
######正向解析
```
[root@dns-server named]# nslookup nginx01.dnsserver.com
Server:		192.168.199.102
Address:	192.168.199.102#53

Name:	nginx01.dnsserver.com
Address: 192.168.199.100
```
#DNS几个查询命令
```
dig -t RT(资源记录类型) NAME [#IP]    #当记录类型不同时，其后所跟的名称也不同  
dig -t NS ZONE_NAME     #通过区域名查询  
dig -x IP：#根据IP查找FQDN  ,在使用该命令时，系统会返回给我们很多信息，我们主要看ANSWER SECTION这个选项的信息
dig +norecurse -t A FQDN @HOST     #通过host主机不递归查询该FQDN，默认情况使用递归查询  
dig +trace -t A FQDN @HOST         #通过host主机追踪查询该FQDN的查询过程  
host -t RT NAME：#查询名称的解析结果  如：# host -t RT www.mageedu.com        
nslookup      #交互式查询界面，与windows下的该命令类似    
nslookup>  
    server IP  
    seT q=RT  
    set q=A  
    NAME  
```

centos7 客户端更换DNS请见 : https://www.jianshu.com/p/bae13defad9b