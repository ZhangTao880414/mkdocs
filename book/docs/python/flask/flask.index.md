
<center><h1> Flask 简介 </h1></center>

## 1. 介绍
&#160; &#160; &#160; &#160;Flask是一个基于Python实现的web开发的'微'框架。

&#160; &#160; &#160; &#160;中文的官网： http://docs.jinkan.org/docs/flask/

&#160; &#160; &#160; &#160;Flask和Django一样，也是一个基于MVC设计模式的Web框架

- a）有非常齐全的官方文档，上手非常方便

- b) 有非常好的拓展机制和第三方的拓展环境，工作中常见的软件都有对应的拓展，自己动手实现拓展也很容易
 
- c) 微型框架的形式给了开发者更大的选择空间

## 2. 安装Flask
```
pip install flask
```
## 3. 创建一个Flask项目
&#160; &#160; &#160; &#160; 创建一个app.py文件(文件名你想起啥就起啥)


```
root@leco:~/code/flask# cat demo.py
from flask import Flask    # 导入Flask包

app = Flask(__name__)      # 获取Flask对象，以当前模块名为参数

# 路由默认为（127.0.0.1:5000）
@app.route('/')            # 装饰器对该方法进行路由设置，请求的地址
def hello_world():         # 方法名称
    return 'Hello World!'  # 返回响应的内容

if __name__ == '__main__':
    app.run('0.0.0.0',7000,debug=True)
```

!!! note "注意"
    ```
    1. 路由，就是你访问的url地址，那部分，你要是学过django，那你就很好的理解了路由，我简单的描述一下。比如你访问www.xxx.com/test，
       后台收到你这样的请求后，进入了对于的视图函数中，然后处理你这个请求，返回数据或者直接显示什么。
    
    2. Flask的路由是route 装饰器装饰的
    
    3. app.run的参数app.run('0.0.0.0',7000,debug=True) 等于 app.run(host='0.0.0.0',port=7000,debug=True)
       1. host 指定访问主机，四个0表示不限制来访的IP
       2. port 配置flask监听的端口是7000，默认是5000
       3. debug=True 表示修改代码的时候。会自动加载。
          1. app.debug = True 等价于 app.run(debug=True)
    ```

## 4. 运行
&#160; &#160; &#160; &#160;通过python 执行app.py文件

```
python app.py
```
服务会默认的起在127.0.0.1:5000,但是我们修改了启动参数，所以会启动在
http://0.0.0.0:7000/

```
root@leco:~/code/flask# python demo.py
 * Running on http://0.0.0.0:7000/ (Press CTRL+C to quit)
 * Restarting with stat
 * Debugger is active!
 * Debugger PIN: 231-067-023

```
&#160; &#160; &#160; &#160; 现在访问 http://192.168.5.110:7000/ ，你会看见 Hello World 问候。浏览器访问如下显示:
![start flask](../../pictures/flask/info.png)

---