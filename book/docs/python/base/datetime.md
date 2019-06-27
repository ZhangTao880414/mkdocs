<center><h1>datetime</h1></center>  

##1. time模块  
###1.1. 获取当前时间
```
>>> import time
>>> time.localtime(time.time())
time.struct_time(tm_year=2019, tm_mon=5, tm_mday=27, tm_hour=2, tm_min=32, tm_sec=50, tm_wday=0, tm_yday=147, tm_isdst=0)

```
###1.2. 格式化时间  
```
>>> import time
>>> localtime = time.asctime( time.localtime(time.time()) )
>>> localtime
'Mon May 27 02:34:30 2019'
```
###1.3. 获取某月日历  
```
>>> import calendar
>>> cal = calendar.month(20019, 5)
>>> cal
'     May 20019\nMo Tu We Th Fr Sa Su\n       1  2  3  4  5\n 6  7  8  9 10 11 12\n13 14 15 16 17 18 19\n20 21 22 23 24 25 26\n27 28 29 30 31\n'
```

##2. datetime模块  
###2.1 获取当前时间  
```
>>> import datetime
>>> datetime.datetime.now()
datetime.datetime(2019, 5, 27, 2, 38, 47, 714759)
```
###2.2 格式化时间  
```
>>> import datetime
>>> datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
'2019-05-27 02:39:54'
```
###2.3 strftime参数  
```
%y     两位数的年份表示（00-99）
%Y     四位数的年份表示（000-9999）
%m     月份（01-12）
%d     月内中的一天（0-31）
%H     24小时制小时数（0-23）
%I     12小时制小时数（01-12）
%M     分钟数（00=59）
%S     秒（00-59）
%a     本地简化星期名称
%A     本地完整星期名称
%b     本地简化的月份名称
%B     本地完整的月份名称
%c     本地相应的日期表示和时间表示
%j     年内的一天（001-366）
%p     本地A.M.或P.M.的等价符
%U     一年中的星期数（00-53）星期天为星期的开始
%w     星期（0-6），星期天为星期的开始
%W     一年中的星期数（00-53）星期一为星期的开始
%x     本地相应的日期表示
%X     本地相应的时间表示
%Z     当前时区的名称
%%     %号本身

```