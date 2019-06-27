###1.简介：
mkdocs 是一个简单、快速 并且 完全静态的网站生成工具。用以构建项目文档页面。使用Markdown编写文档源文件，YAML 编写配置文件。由 mkdocs 生成的是完全静态页面，它可以部署到任何地方

|      名称       |                             版本                             |
| :-------------: | :----------------------------------------------------------: |
|      系统       |             CentOS Linux release 7.6.1810 (Core)             |
|     python      |                            2.7.12                            |
|       pip       |                             1.9                              |
| mkdocs-material |                            4.2.0                             |
|     mkdocs      | 1.04 ；要求python>=2.7.9, !=3.0.*, !=3.1.*, !=3.2.*, !=3.3.* |
|      nginx      |                            1.12.2                            |
|      官网       |                    http://www.mkdocs.org                     |

###2.Python updata :
```
 https://www.jianshu.com/p/97f1c632d018
```
###3.install and upgrade pip ：
```
wget https://bootstrap.pypa.io/get-pip.py 
sudo python get-pip.py
pip install --upgrade pip
```
###4.install mkdocs
```
#download mkdocs：
#https://pypi.org/project/mkdocs/1.0.3/#history
#https://files.pythonhosted.org/packages/2d/91/342005183d45e984a9ffdd28866dbc015a57b509cddf66085a9f49e50e6f/mkdocs-1.0.3-py2.py3-none-any.whl

pip install mkdocs-1.0.3-py2.py3-none-any.whl
pip install mkdocs-material pymdown-extensions

```

###5.close selinux and firewalld
```
systemctl stop fireworld
setenforce 0

vim /etc/selinux/config 
#修改为SELINUX=disabled
```
###6.create project abd start mkdocs
```
mkdir mkdocs
cd mkdocs
mkdocs new book
cd book
mkdocs serve
```
###7.view test
```
curl 127.0.0.1:8000
```

###8.create dir and markdown
```
cd /mkdocs/book/docs
mkdir mysql
touch mysql.delete.md
echo "hello, this is a test" >> mysql.delete.md
```
###9.build static file
```
#build in local
root@mkdocs: /my-notes# mkdocs build
#push to gitHub
root@mkdocs: /my-notes# mkdocs gh-deploy
```
###10.instal nginx and deploy
```
yum install -y nginx

vim /etc/nginx/nginx.conf
#add info below
server {
    listen  8080;
    charset utf-8;

    client_max_body_size 100M;

    location / {
        root    /mkdocs/book/site;
        index   index.html;
    }
}

#restart nginx
root@mkdocs: /my-notes# /etc/init.d/nginx restart
```



###11.小结：
mkdocs很方便，是一个优秀的文档管理器，习惯markdown之后，超级方便。开始愉快的编写自己的文档吧

###12.参考文档： 
https://www.jianshu.com/p/86e81effc891  
https://www.jianshu.com/p/d5308e4c8841  
https://caimengzhi.github.io/books/course/  
