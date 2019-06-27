<center><h1>删除文件夹及文件</h1></center>  

| 字段 | 值 |  
| :-: | :-: |  
| 用途 | 删除指定路径下的所有目录及文件 | 
| ENV | Python3.7.3 |  
| OS | WINDOWS10 |  

``` python
import os
import shutil

def REMOVE_DIR_AND_FILES(DIR):
    dir=DIR 
    try:
        if os.path.exists(dir):
            #获取指定路径下所有目录及文件
            filelist = os.listdir(dir)
            #循环删除文件和目录
            for f in filelist:
            #路径转换为绝对路径
                filepath = os.path.join(dir, f)
                #如果是文件则删除文件
                if os.path.isfile(filepath):
                    os.remove(filepath)
                    print("INFO: "+str(filepath) + " file is removed!")
                #如果是目录则，删除目录
                elif os.path.isdir(filepath):
                    shutil.rmtree(filepath, True)
                    print("INFO: dir " + str(filepath) + " is removed!")
            try:
                #删除总的指定目录
                shutil.rmtree(dir, True)
                print ('INFO: %s is removed' % filepath)
            except:
                print ('ERROR: %s remove error ' % filepath)
        else:
            print("ERROR: the %s is not found" % dir)
    except:
        print ("ERROR: remove dir fail: %s " % dir)

rootdir="D:\work-space\img"

if __name__ == '__main__':
    REMOVE_DIR_AND_FILES(rootdir)

```