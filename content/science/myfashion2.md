+++
title=  " CNN-AlexNet"
date =  2019-11-15T22:41:14+08:00
author = "Angyi"
draft = false
tags = ["CNN","Deeplearning","Mnist-Fashion"]
categories = ["深度学习"]
toc = true
summary= "衣服分类大赛第二轮，Alexnet高调登场！！"
img = "images/AlexNet.png"

+++


## 衣物分类大赛第二轮，AlexNet

衣物分类大赛迎来了第二轮，这一次请来了重量级的参赛选手，Alexnet，它是2012年imagenet的冠军选手，它长这样：
![](http://picture.piggygaga.top/AlexNet/AlexNet.png)

我们这位选手有着超凡的能力，强壮的身体，他的肌肉架构更加丰厚，里面包含的参数也更加多。

网络基本架构为：conv1 (96) -> pool1 -> conv2 (256) -> pool2 -> conv3 (384) -> conv4 (384) -> conv5 (256) -> pool5 -> fc6 (4096) -> fc7 (4096) -> fc8 (1000) -> softmax。AlexNet有着和LeNet-5相似网络结构，但更深、有更多参数。
AlexNet的关键点是：

1. 使用了ReLU激活函数，使之有更好的梯度特性、训练更快。

2.  使用了随机失活(dropout)。

3.  大量使用数据扩充技术。

AlexNet的意义在于它以高出第二名10%的性能取得了当年ILSVRC竞赛的冠军，这使人们意识到卷积神经网络的优势。此外，AlexNet也使人们意识到可以利用GPU加速卷积神经网络训练。AlexNet取名源自其作者名Alex。

他不懈的看着我们的Fashion-Mnist数据集，衣服杀鸡焉用宰牛刀的样子，他拿起来几件衣服，用他复杂的结构玩弄了起来：


```python
# pytorch alexnet
import torch 
from torchvision import datasets,transforms
import torch.utils.data as data
from torch.autograd import Variable
import torch.nn as nn
import matplotlib.pyplot as plt 
```

## 导入数据 设置一些超参数


```python
EPOCH = 5 # 训练次数
LR = 0.001# 学习率
batch_size = 128
num_classes = 10
 

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
    'dataset/', download=True, train=False, transform=transform)
testloader = torch.utils.data.DataLoader(testset, batch_size, shuffle=True)
with torch.no_grad():
    test_x = Variable(torch.unsqueeze(testset.data,dim = 1)).type(torch.FloatTensor)
    test_y = testset.targets
```


```python
# build alexnet module
class Alexnet(nn.Module):
    def __init__(self,num_classes):
        super(Alexnet,self).__init__()
        self.feature = nn.Sequential(
            nn.Conv2d(1,64,kernel_size = 5,stride=1,padding = 0),# 一个通道，输出64张特征图，28-5+1 = 24
            nn.ReLU(inplace=True),# 24*24
            nn.MaxPool2d(kernel_size = 2,stride=2),# 64*12*12

            nn.Conv2d(64,256,kernel_size = 5,padding=1),#256*10*10
            nn.ReLU(inplace=True),# 256*10*10
            nn.MaxPool2d(kernel_size = 4,stride=2), #256*4*4

            nn.Conv2d(256, 384,kernel_size = 3,padding=1),#4-3+2  /1 +1
            nn.ReLU(inplace=True),# 384*4*4
            nn.Conv2d(384, 256,kernel_size = 3,padding=1),# 4-3+2 /1 +1
            nn.ReLU(inplace=True),# 256*4*4
            nn.Conv2d(256, 256,kernel_size = 3,padding=1),
            nn.ReLU(inplace=True),# 256*4*4
            nn.MaxPool2d(kernel_size = 2,stride= 2), # 4-2/2 +1
            
            
            #256*2*2

        )
        self.classifier = nn.Sequential(
            nn.Dropout(),
            nn.Linear(in_features = 1024 ,out_features = 2000),
            nn.ReLU(inplace= True),
            nn.Dropout(),
            nn.Linear(2000,1000),
            nn.ReLU(),
            nn.Linear(1000,num_classes),
        )
    def forward(self,x):
        x = self.feature(x)
        x = x.view(x.size(0),-1)
        x = self.classifier(x)
        return x
```

## 打印网络结构


```python
cnn = Alexnet(10)
print(cnn)
```

    Alexnet(
      (feature): Sequential(
        (0): Conv2d(1, 64, kernel_size=(5, 5), stride=(1, 1))
        (1): ReLU(inplace=True)
        (2): MaxPool2d(kernel_size=2, stride=2, padding=0, dilation=1, ceil_mode=False)
        (3): Conv2d(64, 256, kernel_size=(5, 5), stride=(1, 1), padding=(1, 1))
        (4): ReLU(inplace=True)
        (5): MaxPool2d(kernel_size=4, stride=2, padding=0, dilation=1, ceil_mode=False)
        (6): Conv2d(256, 384, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1))
        (7): ReLU(inplace=True)
        (8): Conv2d(384, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1))
        (9): ReLU(inplace=True)
        (10): Conv2d(256, 256, kernel_size=(3, 3), stride=(1, 1), padding=(1, 1))
        (11): ReLU(inplace=True)
        (12): MaxPool2d(kernel_size=2, stride=2, padding=0, dilation=1, ceil_mode=False)
      )
      (classifier): Sequential(
        (0): Dropout(p=0.5, inplace=False)
        (1): Linear(in_features=1024, out_features=2000, bias=True)
        (2): ReLU(inplace=True)
        (3): Dropout(p=0.5, inplace=False)
        (4): Linear(in_features=2000, out_features=1000, bias=True)
        (5): ReLU()
        (6): Linear(in_features=1000, out_features=10, bias=True)
      )
    )

## 分类

```python
optimizer = torch.optim.Adam(cnn.parameters(),lr = LR )
loss_function = nn.CrossEntropyLoss()


for epoch in range(EPOCH):
    for step,(x,y) in enumerate(trainloader): # 第几个 batch  和 对应的 (x y)
        b_x = Variable(x)
        b_y = Variable(y)

        output = cnn(b_x)
        loss = loss_function(output,b_y) 
        optimizer.zero_grad()

        loss.backward()
        optimizer.step()



        if step % 100 ==0:
#             test_output = cnn(test_x)
#             pred_y = torch.max(test_output,1)[1].data.squeeze()
#             accuracy = torch.div(sum(pred_y == test_y).float(),test_y.size(0)).item()
        
            print('Epoch: ',epoch, '|Step: {:4d} '.format(step) ,'|train loss: {:.4f}'.format(loss.item()))# '|accuracy: {:.4f}'.format(accuracy))


# 计算准确率
correct = 0
total = 0
for images,labels in testloader:
    images = Variable(images)
    outputs = cnn(images)
    _,predict = torch.max(outputs.data,1)
    total += labels.size(0)
    correct += (predict == labels).sum()

corre =  correct.item()/total*100
print("Accuracy of feedforward neural network is {:.2f}%".format(corre))

test_output = cnn(test_x[:20])
pred_y = torch.max(test_output,1)[1].data.numpy().squeeze()
print(pred_y[:20],'prediction number')
print(test_y[:20].numpy(),'real number')

```
## 效果
```powershell
Epoch:  0 |Step:    0  |train loss: 0.1609
Epoch:  0 |Step:  100  |train loss: 0.4251
Epoch:  0 |Step:  200  |train loss: 0.1807
Epoch:  0 |Step:  300  |train loss: 0.3018
Epoch:  0 |Step:  400  |train loss: 0.2718
Epoch:  1 |Step:    0  |train loss: 0.2188
Epoch:  1 |Step:  100  |train loss: 0.1898
Epoch:  1 |Step:  200  |train loss: 0.1618
Epoch:  1 |Step:  300  |train loss: 0.2091
Epoch:  1 |Step:  400  |train loss: 0.2480
Epoch:  2 |Step:    0  |train loss: 0.1617
Epoch:  2 |Step:  100  |train loss: 0.1225
Epoch:  2 |Step:  200  |train loss: 0.1368
Epoch:  2 |Step:  300  |train loss: 0.2527
Epoch:  2 |Step:  400  |train loss: 0.2098
Epoch:  3 |Step:    0  |train loss: 0.0983
Epoch:  3 |Step:  100  |train loss: 0.2152
Epoch:  3 |Step:  200  |train loss: 0.2010
Epoch:  3 |Step:  300  |train loss: 0.1586
Epoch:  3 |Step:  400  |train loss: 0.2021
Epoch:  4 |Step:    0  |train loss: 0.1331
Epoch:  4 |Step:  100  |train loss: 0.1133
Epoch:  4 |Step:  200  |train loss: 0.1445
Epoch:  4 |Step:  300  |train loss: 0.1278
Epoch:  4 |Step:  400  |train loss: 0.2246
Accuracy of feedforward neural network is 90.75%
[9 2 1 1 4 1 4 6 5 7 4 5 3 3 4 1 2 2 8 0] prediction number
[9 2 1 1 6 1 4 6 5 7 4 5 7 3 4 1 2 4 8 0] real number
```

经过一些调参操作之后，可以看出我们的AlexNet选手还是有实力的，不过在这种数据集上优势体现可能不是很明显。

> 为了凸显我们选手的强大，我在调整参数方面做了一点手脚，在标准的Alex Net下这个分类效果其实并不好，准确率也不大高，我调整了后面全联接层的隐藏层神经单元个数，其实对这个MinistFashion数据集来说，我感觉，普通的隐含层全联接神经网络效果是最好的。