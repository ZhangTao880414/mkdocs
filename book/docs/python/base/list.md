<center><h1>List</h1></center>

### 1. 创建列表   
```
>>>list_test = [1, 2, 3, 4, 5, 6, 7]
```

###2. 添加元素  
```
#向列表中添加一个对象object  
>>>list_test.append([8, 9])
>>>list_test
[1, 2, 3, 4, 5, 6, 7,[8, 9]]

#把一个序列seq的内容添加到列表中  
>>>list_test.extend([8, 9])  
>>>list_test
[1, 2, 3, 4, 5, 6, 7,8, 9]
```  

??? note "区别"
    ```
    使用append的时候，是将a1看作一个对象，整体打包添加到a对象中。
    使用extend的时候，是将b1看作一个序列，将这个序列和b序列合并，并放在其后面。
    ```  

###3. 插入一个元素
```
#第一个参数是插入的位置，第二个是插入列表的值，0为列表第一位  
>>>list_test.insert(0, 11)
>>list_test
[11,1, 2, 3, 4, 5, 6, 7]
```  

###4. 获取列表元素
```
#直接使用位置
>>>list_test[1]
11
```

###5. 删除列表元素  
```
#remove：移除指定元素
>>>list_test.remove(11)
>>>list_test
[1, 2, 3, 4, 5, 6, 7]

#pop ：按标记将一个元素抛出列表
>>>list_test.pop()
1
>>list_test
[2, 3, 4, 5, 6, 7]

#del：删除整个列表
>>>del list_test
>>list_test
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'list_test' is not defined
```

###6. 列表分片
```
>>>list_test = [1, 2, 3, 4, 5, 6, 7]
#第一个参数至起始位置，第二个参数指截取多少个
>>>list_test[0:2]
[1, 2]

#从头到尾截取
>>>list_test[:]
[1, 2, 3, 4, 5, 6, 7]

#每隔2个截取一个
>>>list_test[::2]
[1, 3, 5, 7]

#从最后开始截取
>>>list_test[::-1]
[7, 6, 5, 4, 3, 2, 1]
```

###7. list 相加
```
>>>list_test1=[1, 2]
>>>list_test2=[3, 4]
>>>list_test1+list_test2
[1, 2, 3, 4]
```

###8. 判断某个元素是否在列表中
```
>>>list_test = [1, 2, 3, 4, 5, 6, 7]
>>> 10 in list_test
False
>>> 1 in list_test
True
```

###9. 获取列表元素出现的次数
```
>>>list_test = [1, 2, 3, 4, 2, 5, 6, 7, 2]
>>>list_test.count(1)
1
>>>list_test.count(2)
3
``` 

###10 获取元素在列表中的位置
```
>>>list_test = [1, 2, 3, 4, 2, 5, 6, 7, 2]
>>>list_test.index(1)
0
>>list_test.index(2)
1
```  
??? note "注意"
    ```
    当列表中一个元素出现多次时，index显示元素最先在列表中出现的位置  
    ```

###11.列表反转
```
>>>list_test = [1, 2, 3]
>>>list_test.reverse()
>>>list_test
[3, 2, 1]
```

###12. 列表排序  
```
#从小到大
>>>list_test = [1, 3, 2, 4]
>>>list_test.sort()
>>>list_test
[1, 2, 3, 4]

#从大到小
>>>list_test = [1, 3, 2, 4]
>>>list_test.sort(reverse = True)
>>>list_test
[4, 3, 2, 1]
```

###13. 列表拷贝（深/浅复制）    
```
#浅复制也叫引用，指针指向内存同一地址，地址中内容改变，则引用全部改变  
#深复制，两个不同的内存地址存了一样的值，不会互相影响  
>>>list_test1 = [1, 2, 3]
>>>list_test2 = list_test1[:]
>>>list_test3=list_test1
>>>list_test1.remove(1)
>>>list_test1
[2, 3]
>>>list_test3
[2, 3]
>>>list_test2
[1, 2, 3]
  
```