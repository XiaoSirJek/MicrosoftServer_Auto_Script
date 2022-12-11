# MicrosoftServer_Auto_Script

## 简介👾

一个基于[Mohist](https://mohistmc.com/)内核的我的世界服务器部署脚本，包含 Systemctl 管理守护进程，以及一个便捷管理的 Shell Menu.目前已更新 1.12.2 和 1.16.5 版本的服务器安装，已在 Centos 7 服务器上进行测试，文件上传服务 经 Xshell 终端 和 sCRT 终端测试。



## 使用🐱‍🏍

###### **一键部署指令：** 

```shell
yum install wget && wget https://cloud.xiaoyi.ink/d/CodeRepository/mcserver.tar.gz && tar -zxvf mcserver.tar.gz && sh ./mcserver/install.sh
```



## 功能展示🤖

### 快捷方式💨

**基础命令:**`mcm [options] command` ✈

**[options]**

-   access
-   setting
-   status
-   upmod
-   uppulgin
-   help
-   ...... (待更新)

**command**

-   mcm access ->> 快速的向我的世界服务器后台发送指令
-   mcm setting ->> 使用模糊搜索对 `server.properties` 文件进行更改
    -   command 为发送到我的世界服务器指令
-   mcm status [memory|cpu|disk] ->> 资源状态查看(后续会添加正在连接用户以及连接方地址详细信息)
    -   `[]` 内参数待开发
    -   可直接使用 mcm status 进行查看
-   mcm upmod ->> 上传模组
-   mcm uppulgin ->> 上传插件
-   help ->> 命令详解，不是很好，不如这里🤔
-   ...... ->> 后续的白名单管理，黑名单管理，禁止用户登录等功能待开发😅



### 菜单❤

看看就行了，其实没啥和快捷指令一样，基本就那样



## 新功能欲知👨‍🚀

1️⃣自动版本更新(可开启关闭)

2️⃣白名单、黑名单序号添加与删除

3️⃣用户管理(用户权限管理以及用户删除等)

4️⃣...... 其他功能可以提出，能实现的尽量实现



## 须知⚠

🕳**本脚一切只为学习使用，因为第一次进行开发所以写的并不是很好，后续所有功能完善后，全部代码将使用 `C` 进行重写**💻

🕳**后台控制面板使用 Ctrl + B 再轻触 D 键退出，请勿进行其他多余操作以及无谓的测试，如果想自定义后台管理面板，请了解 Tmux 后再进行自定义操作**⌨

🕳**进行自定义脚本功能更改时，请认真阅读完所有代码，如若配置错误导致服务器宕机，皆不会给予任何无偿帮助**🤯



## 问题提交方式📧

📫:xiaosir2022@163.com

🐧:2987715155

💬:在下方留言👇



## 构建人员🦸‍♂️

[BlackCat🐱‍💻](https://blog.xiaoyi.ink/) 

GuGuGe🦃

特别谢明 **[MohistMC](https://mohistmc.com/sponsor)**🙇‍
