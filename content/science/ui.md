+++
author = "Angyi"
comments = true	# set false to hide Disqus
date  = 2020-01-30T23:39:11+08:00
draft = false
share = true	# set false to hide share buttons
tags = ["GUI","PyQt5"]
series = ["Others"]
categories = ["技能杂记"]
toc = true
summary= "PyQt5 练手小项目，过年给亲戚写的方便日常工作的小软件"
title = "PyQt5 GUI项目小项目 "
img = "images/gui.png"
+++

## 基本功能

用GUI的方式对数据库表进行增删改查：

实现了基本的GUI程序对接，基本功能的实现和操作成功与否得信息回馈。


封装成了.exe 感兴趣的同学可以下载使用，运行/dist/main/main.exe
## 笔记小结

1. 可以直接使用QtDesigner来设计软件界面，生成ui文件然后直接用


```shell

pyuic5 -o ui.py source.ui

```

直接将`.ui`文件转换为`.py`文件。


```python 
import ui # 导入生成的py文件
class mainWindow(QMainWindow):
    def __init__(self):
        QMainWindow.__init__(self)
        
        self.ui=ui.Ui_mainWindow() #调用ui中的Ui_mainWindow()实例化对象
        
        self.ui.setupUi(self)
        
        # self.ui.窗口.set各种属性（）
        # self.ui.clicked.connect(self.方法) 连接函数方法
                                    # 注意这个方法不加（）
        
    def 方法（self）：
        内在逻辑
    

```


2. 数据库
选择SQLite数据库，因为其有独特的迁移性优点，不需要扩展的应用，特别适合单用户的本地应用，移动应用和游戏。

3. 逻辑总结

进入软件分开插入模式和查询模式

插入模式：转换为插入模式之后，查询按钮变成写入按钮，用户输入行为规范和条款案例，不能为空，否则状态栏报错，然后点击写入按钮。

查询模式：根据行为规范去查找对应的条款案例，查找采用模糊查询，但是有个缺点就是没有列出多条相似案例的功能。




