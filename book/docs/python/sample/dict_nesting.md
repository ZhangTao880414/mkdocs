<center><h1>字典嵌套赋值</h1></center>  

| 字段 | 值 |  
| :-: | :-: |  
| 用途 | 字典嵌套赋值更新 | 
| ENV | Python3.7.3 |  
| OS | WINDOWS10 |  


- 情况：循环创建多层字典,通过等号给内部的字典赋值，结果所有相关键值全部更新。  
- 原因：字典浅复制，内存地址不变，相当于引用。  
- 解决：每次创建新的字典添加到字典中,不要修改字典值再添加到字典中。  

原代码：  
```python
list1=['a','b']
list2=['name','age']
dict1={}.fromkeys(list1,'test1')
dict2={}.fromkeys(list2,'test2')
print(dict1)
#>>> {'a': '修改前', 'b': '修改前'}

print(dict2)
#>>> {'name': 'test2', 'age': 'test2'}

for key in dict2.keys():
    dict2[key]=dict1
print(dict2)
#>>> {'name': {'a': '修改前', 'b': '修改前'}, 'age': {'a': '修改前', 'b': '修改前'}}

print(dict2['name']['a'])
#>>> 修改前

#只修改了一个键值，结果全部修改了
dict2['name']['a']='修改后'
print(dict2['name']['a'])
#>>> 修改后
print(dict2)
#>>> {'name': {'a': '修改后', 'b': '修改前'}, 'age': {'a': '修改后', 'b': '修改前'}}

```

修改后代码：  
```python
list2=['name','age']
dict2={}.fromkeys(list2,'test2')
print(dict2)
#>>> {'name': 'test2', 'age': 'test2'}
for key in dict2.keys():
    list1 = ['a', 'b']
    dict1 = {}.fromkeys(list1, '修改前')
    print(dict1)
    #>>> {'a': '修改前', 'b': '修改前'}
    dict2[key]=dict1

print(dict2)
#>>> {'name': {'a': '修改前', 'b': '修改前'}, 'age': {'a': '修改前', 'b': '修改前'}}
print(dict2['name']['a'])
#>>> 修改前

dict2['name']['a']='修改后'
print(dict2['name']['a'])
#>>> 修改后
print(dict2)
#>>> {'name': {'a': '修改后', 'b': '修改前'}, 'age': {'a': '修改前', 'b': '修改前'}}
```