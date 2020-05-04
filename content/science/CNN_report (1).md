+++
author = "Angyi"
comments = true	# set false to hide Disqus
date= 2019-10-20T19:59:58+08:00
draft = false
Menu = "ml"		# set "main" to add this content to the 
share = true	# set false to hide share buttons
tags = ["CNN","Deeplearning","迁移学习"]
series = ["ai"]
categories = ["深度学习"]
toc = true
summary= "卷积神经网络的原理初步理解。"
title = "卷积神经网络与迁移学习 "
img = "images/cnn1.png"
+++

# 解密卷积神经网络

主要学习卷积神经网络的两点：
1. CNN的工作原理
2. CNN的优点。与ANN的区别。

## 一. 引言

卷积神经网络的创始人是在Facebook的Yann LeCun工作的著名计算机科学家，他在1989年提出了历史上第一个具有真正意义的卷积神经网络模型LeNet。后来人们改进为LeNet-5,LeNet-5最先被用来处理计算机视觉问题，在识别手写字体的准确性上获得很好的成绩。

![](https://img-0.journaldunet.com/XPrXteY4uHzxXounKVbjhBCh0aQ=/250x/smart/0744f6823657461ebd47a7af55f79a6c/ccmcms-jdn/10823697.jpg) 

单个视觉神经元仅对视野图像中的一小部分做出反应，多个神经元的感受相重叠，得到了我们视觉上的图像。


![](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Neural_pathway_diagram.svg/512px-Neural_pathway_diagram.svg.png)





**电脑“眼中的”图片**

<img src="https://slideplayer.com/10833762/39/images/7/Computer+Vision+What+we+see+What+a+computer+sees.jpg" width="500" hegiht="313" align=center />


## 二. CNN的体系结构:

这里有一篇非常好的CNN网络架构的[博客](https://www.cnblogs.com/skyfsm/p/8451834.html)

这里拿经典的LeNet-5为例：

![](https://cuijiahua.com/wp-content/uploads/2018/01/dl_3_4.jpg)

如上图所示，ConvNet体系结构与常规的ANN体系结构非常相似，尤其是在网络的最后一层（即完全连接的层区域）中。有了前面浅层人工神经网络的基础，这里我们可以很快的理解图中这几个结构。

输入层

输出层

还有最后两层的全连接层。

现在，让我们探索构成ConvNet的各层以及在训练过程中学习到的特征和属性所经历的可视化和分类图片的数学运算。

### Input Layer：

输入层主要是$n×m×3$ RGB图像，这与人工神经网络不同，人工神经网络输入了$n×1$向量。

![](http://www.sai-tai.com/blog/wp-content/uploads/2017/04/cross-section.png)

### 卷积层（Convolution Layer）:

在卷积层中，我们计算输入图像的区域与权重矩阵（称为过滤器）之间的点积输出，过滤器将在整个图像中滑动，并重复相同的点积运算。应该提到两件事：
+ 过滤器必须具有与输入图像相同的通道数。
+ 众所周知，网络越深入，使用的过滤器就越多，其直觉规律是，我们拥有的过滤器越多，边缘和功能检测就越多。

<img src="https://mlnotebook.github.io/img/CNN/convSobel.gif" width="500" hegiht="313" align=center />


Padding 
上面动图可以看出卷积核的大小可能会缩减得到的结果矩阵宽高大小，如果不想失去这些边缘信息，就可以在原矩阵上填充全是0的边缘，长度为$P$


<img src="https://mlnotebook.github.io/img/CNN/convZeros.png" width="500" hegiht="313" align=center />


**参数共享**

当前卷积层中所有过滤器的参数是共享的，这样就可以巨幅减少神经网络上的参数。假设输入层矩阵的的维度为$32*32*3$，第一层卷积层filter尺寸为$5*5$，深度为$16$，那么这个卷积层的参数个数为$5*5*3*16+16=1216$个。如果使用全连接层，那么全连接层的参数个数为$32*32*3*500=1536000$个。相比之下，卷积层的参数个数要远远小于全连接层。卷积层的参数个数与图片的大小无关，它只和filter的尺寸、深度以及当前输入层的深度有关。这使得CNN可以很好地扩展到更大的图像数据上。

<img src="https://img-blog.csdnimg.cn/20190607221819359.gif" width="500" hegiht="313" align=center />


### 卷积层的基本功能：

不同卷积核可以提取不同的特征，例如边沿、线性、角等特征。在深层卷积神经网络中，通过卷积操作可以提取出图像低级到复杂的特征。

比如我们输入的图片是这样：

<img src="https://i.loli.net/2019/10/17/Nm8yUdh625GuX94.png" width="500" hegiht="313" align=center />

如果将卷积核设置成如下两种：

![v2](https://i.loli.net/2019/10/17/SNCTBvib8q4dLxz.png)


识别出来的效果就会是这样，分别提取到了纵向和水平两个层面的边缘特征。

![v3](https://i.loli.net/2019/10/17/FSgGr9AzvoZ6CDM.png)


### 维度总结


卷积层输出的维度


***Output Width:*** $$ \frac{W - F_w + 2P}{S} + 1 $$

***Output Height:*** 
$$ \frac{H - F_h + 2P}{S} + 1 $$
    
    

where:
- $W$: 输入图像的宽度

- $H$: 输入图像的高度

- $F_{w}$: filter的宽度

- $F_{h}$: filter的高度
- $P$: 全0填充的边缘宽度。 
- $S$: 移动步长


假设输入$4*4*3$的图片，filter的大小为$2*2*3$，且使用$m$个filter，步长为1，padding为0，输出为$3*3*m$

就是说使用的filter深度和输入一致，而输出的深度取决于用几个filter。filter可以理解为从图片矩阵中拿几次特征，拿几次摞起来就是输出矩阵。


###  池化层(Pooling Layer)

共有两种广泛使用的类型的池

- 平均池化
- 最大池化

其中最大池化是两者中使用最多的池。池化层用于减少卷积神经网络上的空间尺寸，而不是深度。当使用最大池化层时，我们采用输入区域（n×m矩阵）的最大值（图像中响应最快的区域），而当使用平均池化层时，则采用输入区域的平均值。

![](https://shafeentejani.github.io/assets/images/pooling.gif)

### 全连接层

在FC层中，我们将最后一个卷积层的输出展平，并将当前层的每个节点与下一层的另一个节点连接起来。完全连接层只是常规人工神经网络的另一个词，如您在图像中所见下面。全连接层中的操作与任何人工神经网络中的操作完全相同：

![](https://image.slidesharecdn.com/styletemp-161002182243/95/deep-learning-behind-prisma-8-638.jpg?cb=1475432629)

以上是CNN的前向传播进程。下面我们探讨一下CNN的后向反馈进程。

## 三. Backpropagation

### 1. 在全连接层 

与ANN完全一样，通过计算导数，利用梯度下降法的原理，来更新参数，使得损失函数达到最低。


### 2. 在池化层

池化层的反向传播是静态规则的，也就是说不可导的。下面两张图清晰地表明了池化层反向传播的规律。

- 平均池化反向传播示意图

![](https://img-blog.csdn.net/20170615205352655?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvcXFfMjExOTAwODE=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)



- 最大池化反向传播示意图

![](https://img-blog.csdn.net/20170615211413093?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvcXFfMjExOTAwODE=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)


### 3. 在卷积层

卷积层的向后传播比较复杂，涉及到对矩阵的求导。但是基本原理是一致的。有现成的框架函数可以直接使用。

## 四. 迁移学习
深度学习中，最强大的概念之一就是迁移学习，有时候神经网络从一个任务中习得知识，并将这些知识应用到另一个独立的任务中。

### 1. 什么是迁移学习。

- 例一：
假如你已经训练好了一个网络，能够识别类似猫这样的对象，然后使用这个网络去阅读X射线扫描图，我们要做的就是把神经网络的最后的输出层拿走，把最后一层重新赋予随机权重，让它在放射诊断数据上训练。
- 例二：
假如你已经训练好了一个听语音能转换成文字的神经网络，而现在你要做的事情是语音触发，下达语音指令让机器做某件事情。那完全可以利用这个网络，只需在网络的后面几层中新加几层或者做出修改，来实现现在我们的目标。
![3](https://i.loli.net/2019/10/19/rYWyxmoGLXnd6lR.png)
### 2. 那么为什么可以这么做呢？
比如说刚才的例一，有很多低层次特征，比如边缘检测，曲线检测，对象检测，这些东西已经有了大量的数据来帮你训练的很好了。完全可以拿来用。

### 3. 迁移学习的意义
假如你有很多张猫的数据集，而放射扫描图的数据集却很少。这时候迁移学习就发挥作用了。

- 首先可以用大量的数据集来训练神经网络中的所有参数，训练出神经网络的基本功能。也叫作**预训练**

- 然后再用少量数据去对网络进行训练，修改。也叫作**微调**

### 4. 适用场合
也就是说，迁移学习主要是用在你的数据集太小的时候。

那么这时你完全可以找一个类似的网络，或者是别人训练好的可以完成相似任务的网络。或者是找一个大量的数据集，用来训练神经网络的基本功能，之后再利用你的少量数据进行微调，达到精确地目的。


## 参考文献：

1. [卷积神经网络详解 - 卷积层逻辑篇](https://blog.csdn.net/tjlakewalker/article/details/83275322)
2. [CNN](https://blog.csdn.net/transformer_WSZ/article/details/91161914)
3. [AegeusZerium Deeplearning](https://github.com/AegeusZerium/DeepLearning)
4. [如何通俗理解“卷积”](https://www.matongxue.com/madocs/32.html)
5. [CNN base](https://mlnotebook.github.io/post/CNN1/)
