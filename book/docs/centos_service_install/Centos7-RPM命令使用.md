名称|版本
:-:|:-:|
系统|CentOS Linux release 7.6.1810 (Core) 

#离线下载rpm包
```
在网站中下载需要的rpm包  http://www.rpmfind.net/linux/rpm2html/
or
yum --downloadonly --downloaddir=rmpp install memload-7-1.r29766.x86_64.rpm
```
#RPM包安装
```
rpm -ivh 安装包全名
选项:
    -i(install)    安装
    -v(verbose)    显示详细信息
    -h(hash)       显示进度
    --nodeps       不检测依赖性
```

#RPM包升级
```
rpm -Uvh 包全名
选项:
    -U (upgrade)    升级
```
#RPM包的卸载
```
rpm -e 包名
选项:
    -e (erase)    卸载
    --nodeps      不检测依赖性
```
#RPM包的查询
```
#查询是否安装:
rpm -q 包名
选项:
    -q    查询(query)

#查询所有已经安装的RPM包
rpm -qa
选项:
    -a    所有

#查询软件包的详细信息:
rpm -qi 包名
选项:
    -i    查询软件信息（information）

#查询包中文件安装位置
rpm -ql 包名
选项:
    -l    列表（list）

#查询系统文件属于哪个RPM包
rpm -qf 系统文件名
选项:
    -f    查询系统文件属于哪个RPM包（file）

#查询软件包的依赖性
rpm -qR 包名
选项:
    -R    查询软件包的依赖性（requires）

