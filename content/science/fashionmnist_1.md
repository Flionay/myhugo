+++
title=  " CNN Mini-Fashion数据集以及Pytorch初体验"
date= 2019-10-26T17:59:47+08:00
author = "Angyi"
draft = false
tags = ["CNN","Deeplearning","Mnist-Fashion"]
categories = ["深度学习"]
toc = true
summary= "Pytorch初体验，使用卷积神经网络LeNet5分类Mnist-Fashion,与Feedforward neural network做对比。"
img = "images/mn1.png"
+++


# Mnist-Fashion 数据集

### 下载Fasion-MNIST数据集

`Fashion-MNIST`是一个替代原始的[MNIST手写数字数据集](http://yann.lecun.com/exdb/mnist/)的另一个图像数据集。 它是由Zalando（一家德国的时尚科技公司）旗下的[研究部门](https://research.zalando.com/)提供。其涵盖了来自10种类别的共7万个不同商品的正面图片。Fashion-MNIST的大小、格式和训练集/测试集划分与原始的MNIST完全一致。60000/10000的训练测试数据划分，28x28的灰度图片。你可以直接用它来测试你的机器学习和深度学习算法性能，且**不需要**改动任何的代码。

Fashion-MNIST 数据集的[中文文档说明](https://github.com/zalandoresearch/fashion-mnist/blob/master/README.zh-CN.md)

label包含了image里面64张图片对应的标签

| 标注编号 | 描述               |
| -------- | ------------------ |
| 0        | T-shirt/top（T恤） |
| 1        | Trouser（裤子）    |
| 2        | Pullover（套衫）   |
| 3        | Dress（裙子）      |
| 4        | Coat（外套）       |
| 5        | Sandal（凉鞋）     |
| 6        | Shirt（汗衫）      |
| 7        | Sneaker（运动鞋）  |
| 8        | Bag（包）          |
| 9        | Ankle boot（踝靴） |


```python
import torch  # 导入pytorch
from torch import nn, optim  # 导入神经网络与优化器对应的类
import torch.nn.functional as F
from torchvision import datasets, transforms  # 导入数据集与数据预处理的方法
from torch.autograd import Variable
import matplotlib.pyplot as plt
%matplotlib inline
```
# CNN Le-Net5

## 构建

### 设置超参数


```python
EPOCH = 3 # 训练次数
LR = 1.0E-3 # 学习率
batch_size = 64
```

### 数据预处理：

标准化图像数据，使得灰度数据在-1到+1之间


```python
transform = transforms.Compose(
    [transforms.ToTensor(), transforms.Normalize((0.5,), (0.5,))])

# 下载Fashion-MNIST训练集数据，并构建训练集数据载入器trainloader,每次从训练集中载入64张图片，每次载入都打乱顺序
trainset = datasets.FashionMNIST(
    'dataset/', download=True, train=True, transform=transform)
trainloader = torch.utils.data.DataLoader(
    trainset, batch_size, shuffle=True)

# 下载Fashion-MNIST测试集数据，并构建测试集数据载入器trainloader,每次从测试集中载入64张图片，每次载入都打乱顺序
testset = datasets.FashionMNIST(
    'dataset/', download=True, train=False, transform=transform)
# 分开验证集的输入和标签
with torch.no_grad():
    test_x = Variable(torch.unsqueeze(testset.data,dim = 1)).type(torch.FloatTensor)
    test_y = testset.targets

### 显示图片和标签

```
显示多张图片 绘制封面图片的程序


```python
%matplotlib inline
import matplotlib 
import matplotlib.pyplot as plt
from IPython.core.pylabtools import figsize # import figsize
figsize(12.5, 4) # 设置 figsize
plt.rcParams['savefig.dpi'] = 600 #图片像素
plt.rcParams['figure.dpi'] = 600 #

imagedemo = image[0:50]
imagedemolabel = label[0:50]
labellist = ['T恤','裤子','套衫','裙子','外套','凉鞋','汗衫','运动鞋','包包','靴子']
for i,img in enumerate(imagedemo):
    plt.subplot(5,10,i+1)
    imagedemo = img.reshape((28,28))
    plt.imshow(imagedemo)
```
随机显示一张图片以及对应的标签



```python
image, label = next(iter(trainloader))

# image图片中有64张图片，我们查看索引为2的图片
imagedemo = image[3]
imagedemolabel = label[3]

imagedemo = imagedemo.reshape((28,28))

import matplotlib.pyplot as plt
%matplotlib inline
plt.imshow(imagedemo)

labellist = ['T恤','裤子','套衫','裙子','外套','凉鞋','汗衫','运动鞋','包包','靴子']
print(f'这张图片对应的标签是 {labellist[imagedemolabel]}')
```

    这张图片对应的标签是 包包



![png](https://github.com/Flionay/flionay.github.io/blob/master/images/output_7_1.png?raw=true)

### 构建CNN Le-Net 5 框架


```python
# Building CNN

class CNN(nn.Module):
    def __init__(self):
        super().__init__()
        self.conv1 = nn.Sequential(nn.Conv2d(in_channels=1, out_channels=16, kernel_size=5, stride=1, padding=2,bias=True),
                                   nn.ReLU(),
                                   nn.MaxPool2d(kernel_size=2) # 默认 stride 为 kernel_size
                                   )
        # 输入的维度  输出的特征图个数  卷积核大小  步长  padding  池化大小  （28+4-5）/1 +1 卷积完 16*28*28
        # 池化之后    16*14*14
        self.conv2 = nn.Sequential(nn.Conv2d(in_channels=16,out_channels = 32, kernel_size = 5, stride = 1,padding= 2,bias=True),
                                   nn.ReLU(),# (14+4-5)/1+1  32*14*14
                                   nn.MaxPool2d(2),  # 32*7*7
                                   )  
        self.out = nn.Linear(32*7*7,10) 


    def forward(self, x):
        # make sure input tensor is flattened
        x = self.conv1(x)
        x = self.conv2(x)
        x = x.view(x.size(0),-1)  # 将数据展成一维向量
 
        output = self.out(x)

        return output

```

## 效果


```python
cnn = CNN()
    # print(cnn)

    # params = list(cnn.parameters())
    # print(len(params))
    # print(params[0].size())

optimizer = torch.optim.Adam(cnn.parameters(),lr = LR )
loss_function = nn.CrossEntropyLoss()


for epoch in range(EPOCH):
    for step,(x,y) in enumerate(trainloader): # 第几个 batch  和 对应的 (x y)
        b_x = Variable(x)
        b_y = Variable(y)

        output = cnn(b_x)
        loss = loss_function(output,b_y) 
        optimizer.zero_grad() # 每次batch都会重新初始化参数

        loss.backward() # 反向传播
        optimizer.step() # 参数更新



        if step % 100 ==0:
            test_output = cnn(test_x)
            pred_y = torch.max(test_output,1)[1].data.squeeze()
            accuracy = torch.div(sum(pred_y == test_y).float(),test_y.size(0)).item()
            #print(accuracy)
            print('Epoch: ',epoch, '|Step: {:4d} '.format(step) ,'|train loss: {:.4f}'.format(loss.item()),'|accuracy: {:.4f}'.format(accuracy))


test_output = cnn(test_x[:20])
pred_y = torch.max(test_output,1)[1].data.numpy().squeeze()
print(pred_y[:20],'prediction number')
print(test_y[:20].numpy(),'real number') 
```

    Epoch:  0 |Step:    0  |train loss: 2.3198 |accuracy: 0.0985
    Epoch:  0 |Step:  100  |train loss: 0.5568 |accuracy: 0.6158
    Epoch:  0 |Step:  200  |train loss: 0.4198 |accuracy: 0.7657
    Epoch:  0 |Step:  300  |train loss: 0.4027 |accuracy: 0.7500
    Epoch:  0 |Step:  400  |train loss: 0.4926 |accuracy: 0.8013
    Epoch:  0 |Step:  500  |train loss: 0.5777 |accuracy: 0.8019
    Epoch:  0 |Step:  600  |train loss: 0.4225 |accuracy: 0.7863
    Epoch:  0 |Step:  700  |train loss: 0.3374 |accuracy: 0.7923
    Epoch:  0 |Step:  800  |train loss: 0.3786 |accuracy: 0.8097
    Epoch:  0 |Step:  900  |train loss: 0.5368 |accuracy: 0.7916
    Epoch:  1 |Step:    0  |train loss: 0.4121 |accuracy: 0.8282
    Epoch:  1 |Step:  100  |train loss: 0.1796 |accuracy: 0.8263
    Epoch:  1 |Step:  200  |train loss: 0.3874 |accuracy: 0.8095
    Epoch:  1 |Step:  300  |train loss: 0.1994 |accuracy: 0.7990
    Epoch:  1 |Step:  400  |train loss: 0.2593 |accuracy: 0.8180
    Epoch:  1 |Step:  500  |train loss: 0.3459 |accuracy: 0.8109
    Epoch:  1 |Step:  600  |train loss: 0.2256 |accuracy: 0.8291
    Epoch:  1 |Step:  700  |train loss: 0.2070 |accuracy: 0.8023
    Epoch:  1 |Step:  800  |train loss: 0.1974 |accuracy: 0.8039
    Epoch:  1 |Step:  900  |train loss: 0.2006 |accuracy: 0.8391
    Epoch:  2 |Step:    0  |train loss: 0.1453 |accuracy: 0.7999
    Epoch:  2 |Step:  100  |train loss: 0.2584 |accuracy: 0.8271
    Epoch:  2 |Step:  200  |train loss: 0.3501 |accuracy: 0.7970
    Epoch:  2 |Step:  300  |train loss: 0.2962 |accuracy: 0.8296
    Epoch:  2 |Step:  400  |train loss: 0.1276 |accuracy: 0.8364
    Epoch:  2 |Step:  500  |train loss: 0.1695 |accuracy: 0.8192
    Epoch:  2 |Step:  600  |train loss: 0.1782 |accuracy: 0.7678
    Epoch:  2 |Step:  700  |train loss: 0.2317 |accuracy: 0.7607
    Epoch:  2 |Step:  800  |train loss: 0.1997 |accuracy: 0.7731
    Epoch:  2 |Step:  900  |train loss: 0.3183 |accuracy: 0.8053
    [9 2 1 1 6 1 4 6 5 7 4 5 8 3 4 1 2 4 8 0] prediction number
    [9 2 1 1 6 1 4 6 5 7 4 5 7 3 4 1 2 4 8 0] real number


从结果中可以看出，Le-Net5架构的CNN网络的准确率最高大约为75%-85%.说实话这个效果，不应该是卷积神经网络的威力呀，接下来试一试普通的神经网络看看效果。
# Feedforward neural network
用前向神经网络对比一下，看看效果。

## 构建

```python
## feedforward_nn
import torch 
import torch.nn as nn
import torchvision.datasets as datasets 
import torchvision.transforms as transforms
import matplotlib.pyplot as plt 
import torch.utils.data as data

from torch.autograd import Variable 


input_size = 784
hedden_size = 100
num_classes = 10
num_epochs = 15
batch_size = 64
lr = 0.001

# 数据预处理：标准化图像数据，使得灰度数据在-1到+1之间
transform = transforms.Compose(
    [transforms.ToTensor(), transforms.Normalize((0.5,), (0.5,))])

# 下载Fashion-MNIST训练集数据，并构建训练集数据载入器trainloader,每次从训练集中载入64张图片，每次载入都打乱顺序
trainset = datasets.FashionMNIST(
    'dataset/', download=True, train=True, transform=transform)

trainloader = torch.utils.data.DataLoader(
    trainset, batch_size, shuffle=True)

# 下载Fashion-MNIST测试集数据，并构建测试集数据载入器trainloader,每次从测试集中载入64张图片，每次载入都打乱顺序
testset = datasets.FashionMNIST(
    'dataset/', download=False, train=True, transform=transform)


testloader = torch.utils.data.DataLoader(testset, batch_size, shuffle=True)
with torch.no_grad():
    test_x = Variable(torch.unsqueeze(testset.data,dim = 1)).type(torch.FloatTensor)
    test_y = testset.targets


class Net(nn.Module):
    def __init__(self,input_size,hidden_size,num_calsses):
        super(Net, self).__init__()
        self.fc1 = nn.Linear(input_size,hedden_size)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(hidden_size,num_classes)

    def forward(self, x):
        out = self.fc1(x)
        out = self.relu(out)
        out = self.fc2(out)
        return out

net = Net(input_size,hedden_size,num_classes)
criterion = nn.CrossEntropyLoss()
optimizer = torch.optim.Adam(net.parameters(),lr = lr)


for epoch in range(num_epochs):
    for step,(image,label) in enumerate(trainloader):
        images = Variable(image.view(-1,28*28))
        labels = Variable(label)

        optimizer.zero_grad()
        output = net(images)

        loss = criterion(output,label)
        loss.backward()

        optimizer.step()

        if (step) % 100 == 0:
            loss = loss.item()
            print("Epoch: {:2d}/{:2d}".format(epoch,num_epochs),
                "step: {:3d}/{:d}".format(step,int(len(trainset)/batch_size)),
                "loss: {:4f}".format(loss))


# 计算准确率
correct = 0
total = 0
for images,labels in testloader:
    images = Variable(images.view(-1,28*28))
    outputs = net(images)
    _,predict = torch.max(outputs.data,1)
    total += labels.size(0)
    correct += (predict == labels).sum()
    
corre =  correct.item()/total*100
print("Accuracy of feedforward neural network is {:.2f}%".format(corre))


test_x = test_x[:20].view(-1,28*28)
test_output = net(test_x)
pred_y = torch.max(test_output.data,1)[1].data.numpy().squeeze()
print("real number,",test_y[:20].numpy())
print("pred number,",pred_y)


```
## 效果

```text
Epoch: 14/15 step: 200/937 loss: 0.233361
Epoch: 14/15 step: 300/937 loss: 0.137285
Epoch: 14/15 step: 400/937 loss: 0.177613
Epoch: 14/15 step: 500/937 loss: 0.255258
Epoch: 14/15 step: 600/937 loss: 0.174280
Epoch: 14/15 step: 700/937 loss: 0.132471
Epoch: 14/15 step: 800/937 loss: 0.348314
Epoch: 14/15 step: 900/937 loss: 0.172310
Accuracy of feedforward neural network is 92.24%
real number, [9 0 0 3 0 2 7 2 5 5 0 9 5 5 7 9 1 0 6 4]
pred number, [6 0 0 6 0 2 7 2 5 5 0 9 5 6 0 9 1 2 6 4]
```
这就很尴尬，普通的神经网络效果很好，准确率为92%

。。。。还不知道原因是什么，可能是参数没有设置好，也可能是LeNet架构的缺陷，之后会更新更多的CNN框架，看看效果之后再做对比，分析原因。

# 总结

OK，anyway！

这篇笔记的目的在于学习pytorch的卷积神经网络基本构建方式和构建步骤。
总结为

1. 构造数据集
2. 创建CNN神经网络正向传播对象，需要定制网络的卷积核大小，步长等参数，以及激活函数等。
3. 在epoch循环中，喂进去batchsize，调用cnn对象，正向传播，损失函数，逆向传播，优化算法进行下一步更新。
4. 就算准确率，格式化输出你想要的loss或Accuracy