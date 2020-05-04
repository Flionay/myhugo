+++
author = "Angyi"
comments = true	# set false to hide Disqus
date  = 2019-12-13T12:17:57+08:00
draft = false
share = true	# set false to hide share buttons
tags = ["RNN","Deeplearning"]
series = ["ai"]
categories = ["深度学习"]
toc = true
summary= "LSTM原理与过程"
title = "解密 RNN&LSTM "
img = "images/rnn7.png"
+++

基于全连接神经网络发展而来的CNN和RNN，我们可以简单的把他俩的长处区分为：

- CNN能「看懂」图形
- RNN能「记住」顺序

## 循环神经网络（RNN）

循环神经网络有着能够记住顺序的特点，就像我们阅读文章，理解句子一样，我们不是通过当前阅读的字来判断句子意思的，而是能够连接上文，又一个时间序列的处理特点。
<div align=center><img src="https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn1.png" width = 30% height = 30%/></div> 
在上图网络结构中，对于矩形块 A 的那部分，通过输入xt（t时刻的特征向量），它会输出一个结果ht（t时刻的状态或者输出）。网络中的循环结构使得某个时刻的状态能够传到下一个时刻。

随着时间展开循环网络结果如下面这个图：

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn2.png)

更详细的参数网络结构论文中的这个图更加明确：

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn3.png)


传播函数为

$$ S\_t = tanh(W\_{s\_{t-1}}+Ux\_t) $$




$$o\_t = Vs\_{t-1}$$

从 RNNs 链状的结构很容易理解到它是和序列信息相关的。这种结构似乎生来就是为了解决序列相关问题的。

而且，它们的的确确非常管用！在最近的几年中，人们利用 RNNs 不可思议地解决了各种各样的问题：语音识别，语言模型，翻译，图像（添加）字幕，等等。关于RNNs在这些方面取得的惊人成功，我们可以看 Andrej Karpathy 的博客： [The Unreasonable Effectiveness of Recurrent Neural Networks](http://karpathy.github.io/2015/05/21/rnn-effectiveness/).

RNNs 能够取得这样的成功，主要还是 LSTMs 的使用。这是一种比较特殊的 RNNs，而且对于很多任务，它比普通的 RNNs 效果要好很多很多！基本上现在所使用的循环神经网络用的都是 LSTM.
### RNN 的缺陷
RNN能够很好的解决这类问题，比如说当我们看到“ the clouds are in the ?”时，不需要更多的信息，我们就能够自然而然的想到下一个词应该是“sky”。在这样的情况下，我们所要预测的内容和相关信息之间的间隔很小，这种情况下 RNNs 就能够利用过去的信息， 很容易的实现。
![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn4.png)

但是，有些情况是需要更多的上下文信息。比如我们要预测“I grew up in France … (此处省略1万字)… I speak ?”这个预测的词应该是 Franch，但是我们是要通过很长很长之前提到的信息，才能做出这个正确的预测的呀，普通的 RNNs 很难做到这个。
![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn5.png)
随着预测信息和相关信息间的间隔增大， RNNs 很难去把它们关联起来了。


## LSTM


长短期记忆网络（Long Short Term Memory networks） - 通常叫做 “LSTMs” —— 是 RNN 中一个特殊的类型。由Hochreiter & Schmidhuber (1997)提出，广受欢迎，之后也得到了很多人们的改进调整。LSTMs 被广泛地用于解决各类问题，并都取得了非常棒的效果。

能够记住长时间的序列信息是LSTM与生俱来的能力！

所有循环神经网络结构都是由完全相同结构的（神经网络）模块进行复制而成的。在普通的RNNs 中，这个模块结构非常简单，比如仅是一个单一的 tanh 层。


![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn6.png)


而在LSTM中神经元被设计成了这样：
![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn7.png)

下面详细讲解一下LSTM中神经元的结构：

### 传送带
“传送带”，LSTMs 最关键的地方在于 cell（整个绿色的框就是一个 cell） 的状态 和 结构图上面的那条横穿的水平线。
![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn8.png)
cell 状态的传输就像一条传送带，向量从整个 cell 中穿过，只是做了少量的线性操作。这种结构能够很轻松地实现信息从整个 cell 中穿过而不做改变。这样我们就可以实现了长时期的记忆保留了。


### 门结构

LSTM通过“门”的结构来控制哪些信息可以放到传送带上。

门是一种选择性地让信息通过的方式。主要是通过一个 sigmoid 的神经层 和一个逐点相乘的操作来实现的。 

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn9.png)

sigmoid 层输出（是一个向量）的每个元素都是一个在 0 和 1 之间的实数，表示让对应信息通过的权重（或者占比）。比如， 0 表示“不让任何信息通过”， 1 表示“让所有信息通过”。

每个 LSTM 有三个这样的门结构，来实现保护和控制信息。（译者注：分别是 “forget gate layer”, 遗忘门； “input gate layer”，传入门； “output gate layer”, 输出门）

#### 遗忘门（ forget gate layer）

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn10.png)

首先是 LSTM 要决定让那些信息继续通过这个 cell，这是通过一个叫做“forget gate layer ”的sigmoid 神经层来实现的。它的输入是$h\_{t−1}$和$x\_t$，输出是一个数值都在 0，1 之间的向量（向量长度和 cell 的状态 $C\_{t−1}$ 一样），表示让 $C\_{t−1}$的各部分信息通过的比重。 0 表示“不让任何信息通过”， 1 表示“让所有信息通过”。

回到我们上面提到的语言模型中，我们要根据所有的上文信息来预测下一个词。这种情况下，每个 cell 的状态中都应该包含了当前主语的性别信息（保留信息），这样接下来我们才能够正确地使用代词。但是当我们又开始描述一个新的主语时，就应该把上文中的主语性别给忘了才对(忘记信息)。 

#### 传入门（ input gate layer）

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn11.png)

下一步是决定让多少新的信息加入到 cell 状态 中来。实现这个需要包括两个 步骤：首先，一个叫做“input gate layer ”的 sigmoid 层决定哪些信息需要更新；一个 tanh 层生成一个向量，也就是备选的用来更新的内容，Ct~ 。在下一步，我们把这两部分联合起来，对 cell 的状态进行一个更新。

在我们的语言模型的例子中，我们想把新的主语性别信息添加到 cell 状态中，来替换掉老的状态信息。 
有了上述的结构，我们就能够更新 cell 状态了， 即把$C\_{t−1}$更新为 $C\_t$。 从结构图中应该能一目了然， 首先我们把旧的状态 $C\_{t−1}$和$f\_t$相乘， 把一些不想保留的信息忘掉。然后传送带加上$i\_t*C\_t~$。这部分信息就是我们要添加的新内容。

#### 输出门

![](https://raw.githubusercontent.com/Flionay/flionay.github.io/master/images/rnn12.png)

最后，我们需要来决定输出什么值了。这个输出主要是依赖于 cell 的状态$C\_t$，但是又不仅仅依赖于 $C\_t$，而是需要经过一个过滤的处理。首先，我们还是使用一个 sigmoid 层来（计算出）决定Ct中的哪部分信息会被输出。接着，我们把$C\_t$通过一个 tanh 层（把数值都归到 -1 和 1 之间），然后把 tanh 层的输出和 sigmoid 层计算出来的权重相乘，这样就得到了最后输出的结果。

在语言模型例子中，假设我们的模型刚刚接触了一个代词，接下来可能要输出一个动词，这个输出可能就和代词的信息相关了。比如说，这个动词应该采用单数形式还是复数的形式，那么我们就得把刚学到的和代词相关的信息都加入到 cell 状态中来，才能够进行正确的预测。