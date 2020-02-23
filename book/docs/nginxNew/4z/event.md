####事件驱动模型

    事件驱动模型是实现异步非阻塞的一个手段。事件驱动模型中，一个进程（线程）就可以了。
    
    对于web服务器来说，客户端A的请求连接到服务端时，服务端的某个进程（Nginx worker process）会处理该请求，
    此进程在没有返回给客户端A结果时，它又去处理了客户端B的请求。
    服务端把客户端A以及客户端B发来的请求作为事件交给了“事件收集器”，
    而“事件收集器”再把收集到的事件交由“事件发送器”发送给“事件处理器”进行处理。
    最后“事件处理器”处理完该事件后，通知服务端进程，服务端进程再把结果返回给客户端A、客户端B。
    
    在这个过程中，服务端进程做的事情属于用户级别的，而事件处理这部分工作属于内核级别的。
    也就是说这个事件驱动模型是需要操作系统内核来作为支撑的。
    
####Nginx的事件驱动模型

![image](./nginx_event.png)
    
    Nginx的事件驱动模型，支持select、poll、epoll、rtsig、kqueue、/dev/poll、eventport等。
    最常用的是前三种，其中kqueue模型用于支持BSD系列平台的事件驱动模型。kqueue是poll模型的一个变种，本质上和epoll一样。
    /dev/poll是Unix平台的事件驱动模型，其主要在Solaris7及以上版本、HP/UX11.22及以上版本、IRIX6.5.15及以上版本、
    Tru64 Unix 5.1A及以上版本的平台使用。
    eventport是用于支持Solaris10及以上版本的事件驱动模型。
    

#####select模型

    Linux和Windows都支持，使用select模型的步骤是：
    
    1. 创建所关注事件的描述符集合，对于一个描述符，可以关注其上面的读(Read)事件、写(Write)事件以及异常发生(Exception)事件。
    在select模型中，要创建这3类事件描述符集合。
    
    2. 调用底层提供的select()函数，等待事件发生。
    
    3. 轮询所有事件描述符集合中的每一个事件描述符，检查是否有相应的事件发生，如果有就进行处理。

#####poll模型

    poll模型是Linux平台上的事件驱动模型，在Linux2.1.23中引入的，Windows平台不支持该模型。
    
    poll模型和select模型工作方式基本相同，区别在于，select模型创建了3个描述符集合，而poll模型只创建一个描述符集合。
    
#####epoll模型

    epoll模型属于poll模型的变种，在Linux2.5.44中引入。epoll比poll更加高效，原因在于它不需要轮询整个描述符集合，
    而是Linux内核会关注事件集合，当有变动时，内核会发来通知。