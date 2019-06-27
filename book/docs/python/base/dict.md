<center><h1>dict</h1></center>  

###1. 介绍  
1.字典由键和对应值成对组成。字典也被称作关联数组或哈希表  
2.每个键与值用冒号隔开（:），每对用逗号，每对用逗号分割，整体放在花括号中  
3.键必须独一无二，如果同一个键被赋值两次，后一个值会被记住  
4.一个键键对应的值可以有多个，值可以取任何数据类型，但必须是不可变的，如字符串，数或元组  
```
dict1 = {'name': 'Alice', 'birth': '9102', 'phone': '8008208300'}
dict2 = { 'abc': 456 };
dict3 = { 'abc': 123, 98.6: 37 };
```

###2. 取值  
```
>>>dict1["name"]
'Alice'
```

###3. 更新值  
```
>>>dict1["name"]="tiaozizaixizao"
>>dict1
{'name': 'tiaozizaixizao', 'birth': '9102', 'phone': '8008208300'}

```

###4. 添加元素  
```
>>>dict1["addkey"]="add value"
>>>dict1
{'name': 'tiaozizaixizao', 'birth': '9102', 'phone': '8008208300', 'addkey': 'add value'}
```

###5. 删除元素  
```
#删除键值
>>>del dict1["name"]
>>>dict1
{'birth': '9102', 'phone': '8008208300', 'addkey': 'add value'}
#清空字典
>>>dict1.clear()
>>> dict1
{}
#删除字典
>>>del dict1
>>>dict1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'dict1' is not defined
```

###6. 内置函数  
####6.1 计算个字典的元素个数  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>>len(dict1)
2
```
####6.2 输出字典为可打印的字符串  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>>str(dict1)
"{'name': 'tiaozi', 'age': '10'}"
```
####6.3 返回输入的变量类型  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>>type(dict1)
<class 'dict'>
```
####6.4 字典的复制  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>>dict2=dict1.copy()
>>>dict2
{'name': 'tiaozi', 'age': '10'}

>>>dict1["name"]="dict1 copy"
>>>dict1
{'name': 'dict1 copy', 'age': '10'}

>>dict2
{'name': 'tiaozi', 'age': '10'}
```
####6.5 按值创建字典   
```
#不指定键的值，默认为None
>>>mylist=['name','age','phonenum']
>>>dict1=dict1.fromkeys(mylist)
>>> dict1
{'name': None, 'age': None, 'phonenum': None}

#指定键的值
>>>myvalue=10
>>>dict1=dict1.fromkeys(mylist,myvalue)
>>>dict1
{'name': 10, 'age': 10, 'phonenum': 10}
```
####6.6 获取指定键的值，如果值不在字典中返回默认值None  
```
>>>dict1={"name":'tiaozi',"age":'10'}
#存在键，则返回值
>>>dict1.get('name')
'tiaozi'
#不存在键，则无返回值
>>> dict1.get('phonenum')

#存在键，和键值，则返回键值
>>>dict1.get('name','tiaozi')
'tiaozi'
#不存在键，和键值，则返回定义的键值
>>>dict1.get('phonenum','8008208320')
'8008208320'

```
####6.7 获取字典中所有的键，返回列表  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>> dict1.keys()
dict_keys(['name', 'age'])

```
####6.8 获取字典中所有的键和值，返回list元组  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>> dict1.items()
dict_items([('name', 'tiaozi'), ('age', '10')])

```

####6.9 返回字典中所有的键值,为列表  
```
>>>dict1={"name":'tiaozi',"age":'10'}
>>>dict1.values()
dict_values(['tiaozi', '10'])
```

####6.10 两个字典合并  
```
>>>dict1={"name":'tiaozizaixizao',"age":'10'}
>>>dict2={"phonenum":'8008208320'}
>>>dict3={"learn":['math','english','computer science']}
>>>dict1.update(dict2)
>>>dict1
{'name': 'tiaozizaixizao', 'age': '10', 'phonenum': '8008208320'}

>>>dict1.update(dict3)
>>>dict1
{'name': 'tiaozizaixizao', 'age': '10', 'phonenum': '8008208320', 'learn': ['math', 'english', 'computer science']}
```