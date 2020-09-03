# Dingtalktool

钉钉企业内部应用服务端API，现在已经实现接口：

+ 获取access_token
+ 通讯录管理
    - 部门管理
        + 创建部门
        + 获取子部门ID列表
        + 获取部门列表
        + 获取部门详情
        + 删除部门
    + 用户管理
        + 获取用户详情
        + 获取部门用户
+ 消息通知
    + 创建会话
    + 发送群消息
    + ~bindChat(钉钉文档中找不到)~
+ 考勤
    + 获取打卡详情
    + 获取打卡结果


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dingtalktool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dingtalktool

## Usage

1.添加config/initializers/dingtalktool.rb

```ruby
Dingtalktool.configure do |configuration|
  configuration.corpid = "" # 必填, 企业自用账号信息中CorpId
  configuration.secret = "" # 必填, 开发体验账号管理里面的CorpSecret
  configuration.agentid = "" #必填，在创建微应用的时候会分配
end
```
2.添加配置之后就能直接使用gem提供的功能

+ 获取token
```ruby
token = Dingtalktool::AuthService.getAccessToken  # 返回token字符串
```
+ 获取部门列表
```ruby
department_res = Dingtalktool::DepartmentService.listDept(token)
```
+ 获取部门下所有员工
```ruby
# 获取当个部门员工
department_users = Dingtalktool::UserService.list(token, department_id)
```
+ 获取员工打卡详情
```ruby
userIds = User.all.map(&:userid).uniq
user_ids = Array(userIds.each_slice(50)) # 每次最多查询50位员工,所以这里要把所有员工id分开
result = []
user_ids.each do |users|
    data = {
      userIds: users,
      checkDateFrom: Time.now.beginning_of_day.strftime("%Y-%m-%d %H:%M:%S"),
      checkDateTo: Time.now.end_of_day.strftime("%Y-%m-%d %H:%M:%S"),
      isI18n: 'false'
    }
    listRecord = Dingtalktool::AttendanceService.listRecord(token, data)
    if listRecord['errcode'] == 0 && listRecord['errmsg'] == 'ok'
      result += listRecord['recordresult']
    end
end
```

更多方法请查看下面文件结构

## 文件结构, 类, 方法
├── dingtalktool  
│   &#160;&#160;&#160;&#160;&#160;├── attendance_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── auth_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── cache_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── chat_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── configuration.rb  
│   &#160;&#160;&#160;&#160;&#160;├── department_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── http_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── log_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── message_service.rb  
│   &#160;&#160;&#160;&#160;&#160;├── user_service.rb  
│   &#160;&#160;&#160;&#160;&#160;└── version.rb  
└── dingtalktool.rb  

<table>
  <tr>
    <td>类名</td>
    <td>方法</td>
    <td>备注</td>
  </tr>
  <tr>
    <td rowspan='2'>AttendanceService</td>
    <td>listRecord</td>
    <td></td>
  </tr>
  <tr>
    <td>list</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan='2'>AuthService</td>
    <td>getAccessToken</td>
    <td></td>
  </tr>
  <tr>
    <td>getTicket</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan='3'>ChatService</td>
    <td>createChat</td>
    <td></td>
  </tr>
  <tr>
    <td>bindChat</td>
    <td></td>
  </tr>
  <tr>
    <td>sendmsg</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan='5'>DepartmentService</td>
    <td>createDept</td>
    <td></td>
  </tr>
  <tr>
    <td>listDept</td>
    <td></td>
  </tr>
  <tr>
    <td>list_ids</td>
    <td></td>
  </tr>
  <tr>
    <td>department_info</td>
    <td></td>
  </tr>
  <tr>
    <td>deleteDept</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan='3'>MessageService</td>
    <td>sendToConversation</td>
    <td></td>
  </tr>
  <tr>
    <td>send</td>
    <td></td>
  </tr>
  <tr>
    <td>send_chat</td>
    <td></td>
  </tr>
  <tr>
    <td rowspan='4'>UserService</td>
    <td>getUserInfo</td>
    <td></td>
  </tr>
  <tr>
    <td>get</td>
    <td></td>
  </tr>
  <tr>
    <td>simplelist</td>
    <td></td>
  </tr>
  <tr>
    <td>list</td>
    <td></td>
  </tr>
</table>

## 未完待续
+ 添加所有服务端API
+ 优化调用方式

## 联系方式
有任何问题都联系我 
+ 邮箱: liu_xiaodao@163.com
+ 微信/QQ: 957419420

## 修改记录
1.0.2  缓存文件和日至文件位置修改

## 其他
以上功能是为了满足我自己一个项目写的,所以只包含了钉钉服务端API的一小部分,后面我会持续优化,谢谢,这也是我写的第一个正式的gem

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Liu-XiaoDao/dingtalktool. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Dingtalktool project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Liu-XiaoDao/dingtalktool/blob/master/CODE_OF_CONDUCT.md).
