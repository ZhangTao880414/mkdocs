
<center><h1> MongoDB 数据库操作</h1></center>

## 1. 数据语法
### 1.1 创建语法
&#160; &#160; &#160; &#160;MongoDB 创建数据库的语法格式如下：

```
use DATABASE_NAME
```
如果数据库不存在，则创建数据库，否则切换到指定数据库。

### 1.2 删除语法
&#160; &#160; &#160; &#160;MongoDB 删除数据库的语法格式如下：

```
db.dropDatabase()
```
删除当前数据库，默认为 test，你可以使用 db 命令查看当前数据库名。

## 2. 创建操作
### 2.1 创建数据库
&#160; &#160; &#160; &#160;以下实例创建了数据库 taotaolinux:

```
> use taotaolinux;
switched to db taotaolinux
> db
taotaolinux
```

### 2.2 查看数据库
&#160; &#160; &#160; &#160;如果你想查看所有数据库，可以使用 show dbs 命令：
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
```
可以看到，刚创建的数据库 taotaolinux 并不在数据库的列表中， 要显示它，需要向 taotaolinux 数据库插入一些数据。
```
> db.taotaolinux.insert({'name':'taotaolinux'})
WriteResult({ "nInserted" : 1 })
> show dbs;
admin   0.000GB
taotaolinux     0.000GB
config  0.000GB
local   0.000GB
>

```

&#160; &#160; &#160; &#160;MongoDB 中默认的数据库为 test，如果你没有创建新的数据库，集合将存放在 test 数据库中。

??? tip "注意"
    ```python
    在 MongoDB 中，集合只有在内容插入后才会创建! 就是说，创建集合(数据表)后要再插入一个文档(记录)，集合才会真正创建。
    ```

## 3. 删除操作
### 3.1 删除数据库
&#160; &#160; &#160; &#160;以下实例删除了数据库 taotaolinux。首先，查看所有数据库：

```
> show dbs;
admin   0.000GB
taotaolinux     0.000GB
config  0.000GB
local   0.000GB
```
接下来切换到数据库 taotaolinux：

```
> use taotaolinux;
switched to db taotaolinux
```
执行删除命令：

```
> db.dropDatabase()
{ "dropped" : "taotaolinux", "ok" : 1 }
```
最后，再通过 show dbs 命令数据库是否删除成功：
```
> show dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
```
