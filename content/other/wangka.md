---
title: "黑苹果Dw1560网卡驱动"
date: 2020-04-23T22:26:37+08:00
comments : true
tags : ["Hackintosh"]
categories : ["技能杂记"] ## python 深度学习 机器学习 其他 数据分析 海洋大气
# series : ["ai"] # python ai others ocean
toc : true
summary : "实现无限wifi，蓝牙，隔空投送。"
---

将这几项驱动放入`EFI\CLOVER\kexts\others` 即可。

![](/Users/ay/Library/Application Support/typora-user-images/image-20200423113448633.png)

第一次安装使用黑果小兵自带`config_installer.plist`网卡直接驱动，替换plist之后网卡发生异常，无法驱动。所以建议根据找到的相似配置EFI修改镜像自带EFI。不建议直接替换。

![image-20200423113726042](/Users/ay/Library/Application Support/typora-user-images/image-20200423113726042.png)

蓝牙在放入驱动之后，基本无需任何操作，免驱。

![h8y1c6](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/h8y1c6.png)
