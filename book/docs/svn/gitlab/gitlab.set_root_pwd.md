<center><h1>Gitlab 重置root登录密码</h1></center>
时间长突然忘记了root账号的密码，以下是找回密码过程
## 找回步骤

```
[root@leco gitlab]# su - git
-sh-4.1$ gitlab-rails console production
-------------------------------------------------------------------------------------
 GitLab:       11.7.5 (c5b5b18)
 GitLab Shell: 8.4.4
 postgresql:   9.6.11
-------------------------------------------------------------------------------------
Loading production environment (Rails 5.0.7.1)
irb(main):001:0> user = User.where(id: 1).first       # 确定是否是root用户
=> #<User id:1 @root>
irb(main):002:0> user.password = 'taotaolinux!\#@809'  # 设置登录账号root的密码
=> "taotaolinux!\#@809"
irb(main):003:0> user.save!
Enqueued ActionMailer::DeliveryJob (Job ID: 26a68d46-d3f4-46a1-92c8-79057ec4a13f) to Sidekiq(mailers) with arguments: "DeviseMailer", "password_change", "deliver_now", #<GlobalID:0x00007f225e449bc0 @uri=#<URI::GID gid://gitlab/User/1>>
=> true
irb(main):004:0> exit
```
再次登录 使用

账号:  root

密码: taotaolinux!\#@809
