###1 日志格式配置
```
#备份nginx.conf 配置文件。
#修改配置，按如下设置日志记录文件、记录内容、记录格式，添加标签为main的log_format格式
#(http标签内，在所有的server标签内可以调用)：
log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
   '$status $body_bytes_sent "$http_referer" '
   '"$http_user_agent" "$http_x_forwarded_for"';

# 在server标签内，定义日志路径
access_log logs/host.access.log main

# 保存，然后后重启nginx服务。
```

###2 禁止目录浏览
```
#备份nginx.conf配置文件。

#编辑配置文件，HTTP模块添加如下一行内容：
autoindex off;

#保存，然后后重启nginx服务。
```

###3 限制目录执行权限
```
#备份nginx.conf配置文件。
#编辑配置文件，在server标签内添加如下内容：
#示例：去掉单个目录的PHP执行权限
location ~ /attachments/.*\.(php|php5)?$ {
    deny all;
}

#示例：去掉多个目录的PHP执行权限
location ~
/(attachments|upload)/.*\.(php|php5)?$ {
    deny all;
}

#保存，然后后重启nginx服务。
#注意两点：
　　　　1、以上的配置文件代码需要放到 location ~ .php{...}上面，如果放到下面是无效的;
　　　　2、attachments需要写相对路径，不能写绝对路径。
```
###4 错误页面重定向
```
#备份nginx.conf配置文件。
#修改配置，在http{}段加入如下内容
#其中401.html、402.html、403.html、404.html、
#405.html、500.html 为要指定的错误提示页面。
http {
...
    fastcgi_intercept_errors on;
    error_page 401 /401.html;
    error_page 402 /402.html;
    error_page 403 /403.html;
    error_page 404 /404.html;
    error_page 405 /405.html;
    error_page 500 /500.html;
...
}
修改内容：
http {
    ErrorDocument 400 /custom400.html
    ErrorDocument 401 /custom401.html
    ErrorDocument 403 /custom403.html
    ErrorDocument 404 /custom404.html
    ErrorDocument 405 /custom405.html
    ErrorDocument 500 /custom500.html
}

#保存，重启 nginx 服务生效

```

### 5 隐藏版本信息
```
#备份nginx.conf配置文件。
#编辑配置文件，添加http模块中如下一行内容：
server_tokens off;
#保存，重启 nginx 服务生效
```

###6 限制HTTP请求方法
```
#备份nginx.conf配置文件。
#编辑配置文件，添加内容：
if ($request_method !~ ^(GET|HEAD|POST)$ ) {
    return 444;
}
#保存，重启 nginx 服务生效
#备注：只允许常用的GET和POST方法，顶多再加一个HEAD方法
```

###7 限制IP访问
```
#备份nginx.conf配置文件。
#编辑配置文件，在server标签内添加如下内容：
location / {
    deny 192.168.1.1; #拒绝IP
    allow 192.168.1.0/24; #允许IP
    allow 10.1.1.0/16; #允许IP
    deny all; #拒绝其他所有IP
}

#保存，重启 nginx 服务生效
```

###8 限制并发和速度
```
#备份nginx.conf配置文件。
#编辑配置文件，在server标签内添加如下内容：
limit_zone one $binary_remote_addr 10m;
server
{
     listen   80;
     server_name down.test.com;
     index index.html index.htm index.php;
     root  /usr/local/www;
     #Zone limit;
     location / {
         limit_conn one 1;
         limit_rate 20k;
     }
}
#保存，重启 nginx 服务生效
```
###9 控制超时时间
```
#备份nginx.conf配置文件。
#编辑配置文件，http 标签内添加：
client_body_timeout 10;  #设置客户端请求主体读取超时时间
client_header_timeout 10;  #设置客户端请求头读取超时时间
keepalive_timeout 5 5;  #第一个参数指定客户端连接保持活动的超时时间，第二个参数是可选的，它指定了消息头保持活动的有效时间
send_timeout 10;  #指定响应客户端的超时时间

#保存，重启 nginx 服务生效
```

###10 Nginx降权
```
#备份nginx.conf配置文件。
#编辑配置文件,添加如下一行内容，指定启动用户：
user nobody;
#保存，重启 nginx 服务生效
```

### 11防盗链
```
#备份nginx.conf配置文件。
#编辑配置文件,在server标签内添加如下内容：
location ~* ^.+\.(gif|jpg|png|swf|flv|rar|zip)$ {
    valid_referers none blocked server_names *.nsfocus.com http://localhost baidu.com;
    if ($invalid_referer) {
        rewrite ^/ [img]http://www.XXX.com/images/default/logo.gif[/img];
        # return 403;
    }
}
#保存，重启 nginx 服务生效
```
###12 反爬虫
```
#原理：根据客户端的user-agents信息，阻止指定的爬虫爬取的网站
#参考链接：https://zhang.ge/4458.html
#server标签内添加以下内容

#禁止以下爬虫代理抓取
if ($http_user_agent ~* "qihoobot|Baiduspider|Googlebot|Googlebot-Mobile|Googlebot-Image|Mediapartners-Google|Adsbot-Google|Feedfetcher-Google|Yahoo! Slurp|Yahoo! Slurp China|YoudaoBot|Sosospider|Sogou spider|Sogou web spider|MSNBot|ia_archiver|Tomato Bot") 
{ 
    return 403; 
} 

#禁止Scrapy等工具的抓取
if ($http_user_agent ~* (Scrapy|Curl|HttpClient)) {
     return 403;
}
 
#禁止指定UA及UA为空的访问
if ($http_user_agent ~ "WinHttp|WebZIP|FetchURL|node-superagent|java/|FeedDemon|Jullo|JikeSpider|Indy Library|Alexa Toolbar|AskTbFXTV|AhrefsBot|CrawlDaddy|Java|Feedly|Apache-HttpAsyncClient|UniversalFeedParser|ApacheBench|Microsoft URL Control|Swiftbot|ZmEu|oBot|jaunty|Python-urllib|lightDeckReports Bot|YYSpider|DigExt|HttpClient|MJ12bot|heritrix|EasouSpider|Ezooms|BOT/0.1|YandexBot|FlightDeckReports|Linguee Bot|^$" ) {
     return 403;             
}
 
#禁止非GET|HEAD|POST方式的抓取
if ($request_method !~ ^(GET|HEAD|POST)$) {
    return 403;
}

#保存，平滑重启nginx：
nginx -s reload

```

### 13补丁更新
```
1、软件信息
查看软件版本 nginx -v 
测试配置文件 nginx –t
2、补丁安装
手动安装补丁或安装最新版本软件
```