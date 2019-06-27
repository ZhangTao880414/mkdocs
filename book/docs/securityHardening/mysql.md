###1.数据库加固

####1.1 禁用mysql历史命令
```
Rm ~/.mysql_history；
```
####1.2 相关安全设置；
```
mysqlsecureinstallation
```
####1.3 使用validate_password.so插件，进行安全加固；

####1.4 重命名 ROOT 账户；
```
Update user set user=”新用户名”where user=”root” 
```
####1.5 控制最高权限只有管理员
```
SELECT user, host FROM mysql.user WHERE (Select_priv = 'Y') OR (Insert_priv = 'Y') OR (Update_priv = 'Y') OR (Delete_priv = 'Y') OR (Create_priv = 'Y') OR (Drop_priv = 'Y');SELECT user, host FROM mysql.db WHERE db = 'mysql' AND ((Select_priv = 'Y') OR (Insert_priv = 'Y') OR (Update_priv = 'Y')OR (Delete_priv = 'Y') OR (Create_priv = 'Y') OR (Drop_priv = 'Y'));

```
####1.6 删除默认test数据库，测试帐号，空密码、匿名帐号：
```
bash drop database if exists ${dbname};bash drop user ''select user,host from mysql.user
```
####1.7 关闭Old_Passwords：
```
show variables like ‘%password%’；
```
####1.8 确保所有用户都要求使用非空密码登录：
```
SELECT User,host FROM mysql.user WHERE (plugin IN('mysql_native_password', 'mysql_old_password') AND (LENGTH(Password)= 0 OR Password IS NULL)) OR (plugin='sha256_password' AND LENGTH(authentication_string) = 0);

```
####1.9 禁止MySQL对本地文件存取
```
Less /etc/my.cnf。
```