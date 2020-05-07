---
title: "黑苹果原生态声卡驱动"
date: 2020-04-23T22:24:25+08:00
comments : true
tags : ["Hackintosh"]
categories : ["技能杂记"] ## python 深度学习 机器学习 其他 数据分析 海洋大气
# series : ["ai"] # python ai others ocean
toc : true
summary : "黑苹果板载声卡原生态驱动方式"
---

打开主板官网，找到自己的主板，查看相对应的声卡型号。
![](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/DDk51A.png)


下载AppleHDA Pacher
![LXZFIx](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/LXZFIx.png)

根据笔记本或者台式机实际情况选择对应型号的声卡型号，点击Pached，会在桌面生成MironeAudio文件夹；

找到第一个数字文件夹下的config.plist用clover configurator软件查看layoutID，修改自己EFI分区内的config.plist为同样的声卡ID。
![mQUyk8](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/mQUyk8.png)

找到第三个文件夹下的AppleHDA.kext用Utility kexts软件注入驱动。
![g3ZnVj](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/g3ZnVj.png)
将HDAEnabler5文件夹下的HDAEnabler.kext驱动放置在EFI分区`kexts/others`文件夹下 。

重启电脑

原生态声卡驱动成功，耳机外放自动切换，没有噪音杂音，不会产生炸音。

![Fpu5mU](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/Fpu5mU.png)