---
author : "Angyi"
comments : true # set false to hide Disqus
date  : 2020-04-05T12:17:57+08:00
draft : false
share : true    # set false to hide share buttons
tags : 
    - 博客
    - Hugo
    - 域名
categories : 博客
toc : true
summary: "gitee page pro 添加自定义域名，新博客地址更新为www.angyi.online"
title : " hugo+gitee page pro 实现自定义域名访问博客 "
---


## 写在前面
1. hugo+github page是最佳拍档，也有很多人用这种方式发布个人博客，但是由于github的墙外属性，导致国内访问速度很慢。
2. hugo+gitee page,国内也做起了类似GitHub的代码管理仓库gitee码云，相比较于github对国内访问更加友好，而且同样提供page部署功能，但是不能自定义域名，必须按照固定的生成地址格式访问。
3. gitee page pro，当然很多东西不是不能，能与不能之间往往只差一个VIP，git page开通VIP之后就能够自定义域名，自动更新部署。年会员99元，【在这种事情上，和朋友出去吃顿饭的话会毫不犹豫，真正有用的东西却会觉得很贵呵呵】。

## 购买域名
在腾讯云或者阿里云选择域名注册服务，然后输入自己想要的地址，看价格选择后缀，购买服务，过程中需要实名认证。

![obsYHL](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/obsYHL.png)
## 设置域名解析
购买之后需要配置DNS解析，将域名定向到github page的IP地址上，按照下面的表格添加两条解析记录。之后回到github page页面添加域名即可。想要获得GitHub默认域名的IP地址，只需要ping一下网址即可。

![42U734](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/42U734.png)
## 设置gitee page pro
如果是用git page pro的话，只需要添加CNAME解析记录，并且解析到gitee.gitee.com即可。然后将网址添加到gitee page设置里面。
![sjfhET](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/sjfhET.png)
## 开启https
这是就能够访问了。如果想要开启强制https，需要在购买域名的地方，我这里选用的是阿里云，在SSL证书那里选购一个，选择免费的那个就可以了，实名认证之后一个小时就可以下载到证书密钥了，选择nginx证书添加到giteepage 设置里面就可以了。
## 修改博客config.toml
![Z4ILzJ](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/Z4ILzJ.png)
大功告成！
## 添加到百度搜索资源平台上

打开[百度资源平台](https://ziyuan.baidu.com),点击链接提交，帮助网站快速收录

![4PIbae](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/4PIbae.png)

完善百度账号信息之后，跳转到以下界面，选择CNAME验证，生成验证码

![UxnQep](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/UxnQep.png)

在阿里云购买的域名云解析DNS上添加解析记录；

验证成功之后，理论上是被百度搜索平台收录了，但是由于涉及到推荐，所以想要出现在百度结果第一个，¥，你懂的。所以这个也就不追求了，有时间再搞吧。