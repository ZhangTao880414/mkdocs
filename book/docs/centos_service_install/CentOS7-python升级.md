名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 
python 旧版|2.7.5
python 升级|2.7.12

```
#centos原装Python2.7.5
#查看Python版本:python2.7.5
python --version

#获取python2.7.12安装包，并解压

wget https://www.python.org/ftp/python/2.7.12/Python-2.7.12.tgz
tar -zxvf Python-2.7.12.tgz

#编译
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc  libffi-devel
cd Python-2.7.12
mkdir -p /usr/local/python2.7.12
./configure --prefix=/usr/local/python2.7.12
make && make install

#备份老版python并建立软连接
/usr/local/python2.7.12/bin/python -V 
mv /usr/bin/python /usr/bin/python2.7.5
ln -s /usr/local/python2.7.12/bin/python /usr/bin/python

#查看python版本
python -V 

#配置yum到老版本python
vi /usr/bin/yum 
vim /usr/libexec/urlgrabber-ext-down
将文件头部的#!/usr/bin/python 改成#!/usr/bin/python2.7.5


#添加环境变量
vi /etc/profile
export  PATH="$PATH:/usr/local/python2.7.12/bin/"
#刷新生效
source /etc/profile

#升级pip
wget https://bootstrap.pypa.io/get-pip.py 
sudo python get-pip.py
pip install --upgrade pip

```   

??? note "python3安装"

    ```python   
    python3 方式和2相同只是安装包不同。   
    python3下载链接： https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz   
    pip3 install:
    wget --no-check-certificate https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz   
    tar -zxvf setuptools-19.6.tar.gz 
    cd setuptools-19.6   
    python3 setup.py build   
    python3 setup.py install   
    ```