<center><h1>tuple</h1></center>  

###1. 创建元祖  
```
>>> tup1 = ('Google', 'Runoob', 1997, 2000);
>>> tup2 = (1, 2, 3, 4, 5 );
>>> type(tup2)
<class 'tuple'>
>>> type(tup1)
<class 'tuple'>

#特别注意：不需要括号也可以
>>> tup3 = "a", "b", "c", "d";
>>> type(tup3)
<class 'tuple'>

```  

??? note "注意"
    ```
    元组使用小括号,元组的元素不能修改,元素用逗号隔开    
    元组中只包含一个元素时，需要在元素后面添加逗号，否则括号会被当作运算符使用  
    ```  

###2. 访问元组  
```
#用法和list一样  
>>>tup1 = ('Google', 'Runoob', 1997, 2000)
>>> tup1[0]
'Google'
>>> tup1[0:2]
('Google', 'Runoob')
>>> tup1[:]
('Google', 'Runoob', 1997, 2000)
>>> tup1[::-1]
(2000, 1997, 'Runoob', 'Google')

```  

###3. 删除元组  
```
#不允许删除元祖元素，可以删除整个元组  
>>> tup1 = ('Google', 'Runoob', 1997, 2000)

>>> tup1.remove()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AttributeError: 'tuple' object has no attribute 'remove'

>>> del tup1
>>> tup1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'tup1' is not defined

```  

###4. 元组更新  
```
#使用截取，添加的方式  
>>> tup1=(1,2,3,4,5)
>>> tup1=tup1[0:2]+tup1[4:5]
>>> tup1
(1, 2, 5)

>>>tup2=(7,8)
>>>tup2=tup1[:] + tup2[:]
>>tup2
(1, 2, 5, 7, 8)
```

###5. 元组内置函数  
####5.1 计算元组元素个数  
```
>>> tuple1 = ('Google', 'Runoob', 'Taobao')
>>> len(tuple1)
3
```
####5.2 元组中元素最大值  
```	
>>> tuple2 = ('5', '4', '8')
>>> max(tuple2)
'8'
```
####5.3 元组中元素最小值  
```	
>>> tuple2 = ('5', '4', '8')
>>> min(tuple2)
'4'
```
####5.4  列表转换为元组  
```
>>> list1= ['Google', 'Taobao', 'Runoob', 'Baidu']
>>> tuple1=tuple(list1)
>>> tuple1
('Google', 'Taobao', 'Runoob', 'Baidu')
```