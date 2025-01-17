---
title: "CART 算法"
date: 2020-04-18T22:07:30+08:00
comments : true
tags : ["机器学习","算法"]
categories : ["机器学习"] ## python 深度学习 机器学习 其他 数据分析 海洋大气
series : [others]
toc : true
summary : "分类与回归树算法"
---

# CART
分类与回归树（classification and regression tree, CART）模型是应用广泛的决策树学习方法，同样由特征选择、树的生成和剪枝组成，既可以用于分类也可以用于回归。

CART假设决策树是二叉树，内部结点特征的取值为“是”和“否”，左分支是取值为“是”的分支，右分支是取值为“否”的分支。

CART算法主要由以下两步组成：

1. 决策树生成：基于训练数据集生成决策树，生成的决策树要尽量大。
2. 决策树剪枝：用验证数据集对已生成的树进行剪枝并选择最优子树，这时用损失函数最小作为剪枝的标准。

# CART生成

决策树的生成就是递归地构建二叉决策树的过程，对回归树用*平方误差最小化*准则，对分类树用*基尼系数最小化*准则，进行特征选择，生成二叉树。 回归树的生成

假设$ X $

与$Y$分别为输入和输出变量，并且$Y$

是连续变量，给定训练数据集

$$ D={(x_1,y_1),(x_2,y_2),⋯,(x_N,y_N)} $$


![bJt8e3](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/bJt8e3.png)

对每个区域$R_1$和$R_2$重复上述过程，将输入空间划分为*M*个区域$R_1$,$R_2$,⋯,$R_M$，在每个区域上的输出为$c_m$,m=1,2,⋯,M，最小二乘回归树可表示为
$$
f(x)=\sum_{m=1}^{M} c_{m} I\left(x \in R_{m}\right)
$$

### 最小二乘回归树生成算法

输入：训练数据集$D$
输出：回归树$f(x)$

![8CQJk4](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202004/8CQJk4.png)



## 分类树的生成

分类树用基尼指数选择最优特征，同时决定该特征的最优二值切分点。

分类问题中，假设有$K$个类，样本点属于第k类的概率为$p_k$，则概率分布的基尼指数定义为：

$$
\operatorname{Gini}(p)=\sum_{k=1}^{2} p_{k}\left(1-p_{k}\right)=2 p(1-p)
$$

对于二类分类问题，若样本点属于第1类的概率为$P$,，则概率分布的基尼指数为：

$$
\operatorname{Gini}(p)=\sum_{k=1}^{2} p_{k}\left(1-p_{k}\right)=2 p(1-p)
$$

对于给定样本集和$D$,其基尼指数为：

$$
\operatorname{Gini}(D)=1-\sum_{k=1}^{K}\left(\frac{\left|C_{k}\right|}{|D|}\right)^{2}
$$
其中，$C_k$是$D$中属于第$k$类的样本自己，$K$是类别个数。

如果样本集合$D$根据特征$A$是否取某一可能值a被分割成$D_1$和$D_2$两个部分，即

$$
D_{1}=\{(x, y) | A(x)=a\}, \quad D_{2}=D-D_{1}
$$

则在特征$A$的条件下，集合$D$的基尼指数为：

$$
\operatorname{Gini}(D, A)=\frac{\left|D_{1}\right|}{|D|} \operatorname{Gini}\left(D_{1}\right)+\frac{\left|D_{2}\right|}{|D|} \operatorname{Gini}\left(D_{2}\right)
$$


基尼指数$Gini(D)$表示集合$D$的不确定性，基尼指数Gini(D,A)表示经*A*=*a*分割后集合*D*

的不确定性。基尼指数值越大，样本集合的不确定性也越大，这一点与熵类似。

### CART生成算法

输入：训练数据集$D$

，特征$A$，阈值$ε$


输出：CART决策树

1. 设结点的训练数据集为$D$

，对每一个特征$A$，对其可能取的每个值$a$，根据样本点对$A=a$的测试为“是”或“否”将$D$分割成$D_1$和$D_2$两部分，并计算$Gini(D,A)$。

2. 在所有可能的特征*A*以及其所有可能的切分点*a*中，选择基尼指数最小的特征及其对应的切分点作为最优特征与最优切分点。依此从现结点生成两个子结点，将训练数据集依特征分配到两个子结点中去。

3. 对两个子结点递归地调用1.和2.，直至满足停止条件。

生成CART决策树$*T*$

算法停止计算的条件是结点中的样本个数小于预定阈值，或样本集的基尼指数小于预定阈值（样本基本属于同一类），或者没有更多特征。

# CART剪枝

CART剪枝算法从“完全生长”的决策树低端剪去一些子树，使决策树边小，从而能够对未知数据有更准确的预测。

## 剪枝，形成一个子树序列 *T*0,*T*1,…,*T*n*

## 

对整体树$T_0$任意内部结点$t$，以$t$为单结点树的损失函数是：

$$C_α(t)=C(t)+α$$

以$t$为根结点的子树$T_t$的损失函数是：

$$
C_{\alpha}\left(T_{t}\right)=C\left(T_{t}\right)+\alpha\left|T_{t}\right|
$$

当*α*=0及*α*充分小时，有不等式：

$$
C_{\alpha}\left(T_{t}\right)<C_{\alpha}(t)
$$

当*α*增大时，在某一*α*有：
$$
\begin{array}{c}
C_{\alpha}\left(T_{t}\right)=C_{\alpha}(t) \\
C\left(T_{t}\right)+\alpha\left|T_{t}\right|=C(t)+\alpha \\
\alpha=\frac{C(t)-C\left(T_{t}\right)}{\left|T_{t}\right|-1}
\end{array}
$$

即$T_t$与$t$有相同的损失函数值，而$t$的结点少，因此对$T*t$进行剪枝。

## 在剪枝得到的子树序列  *T*0,*T*1,…,*T*n*中通过交叉验证选取最优子树*T*n*

具体地，利用独立的验证数据集，测试子树序列 *T*0,*T*1,…,*T*n中各棵子树的平方误差或基尼指数。平方误差或基尼指数最小的决策树被认为是最优的决策树。在子树序列中，每棵子树 *T*0,*T*1,…,*T*n* 都对应一个参数*α*1,*α*2,…,*α*n。所以，当最优子树*T*k*确定时，对应的*α*k*也确定了，即得到最优决策树$T_α$。

## CART剪枝算法

输入：CART决策树$T_0$


输出：最优决策树$T_α$



1. 设$k=0,T=T_0$



2. 设$α=+∞$



3. 自下而上地对各内部结点$t$计算$C(T_t),|T_t|$，以及
$$
\begin{aligned}
&g(t)=\frac{C(t)-C\left(T_{t}\right)}{\left|T_{t}\right|-1}\\
&\alpha=\min (\alpha, g(t))
\end{aligned}
$$

其中，$T_t$表示以$t$为根结点的子树，$C(T_t)$是对训练数据的预测误差，$|T_t|$是$T_t$的叶结点个数。

4. 自下而上地访问内部结点$t$，如果有$g(t)=α$，则进行剪枝，并对叶结点$t$以多数表决法决定其类别，得到树$T$



5. 设$k=k+1,α_k=α,T_k=T$



6. 如果$T$不是由根结点单独构成的树，则回到步骤4.

采用交叉验证法在子树序列$T_0$,$T_1$,⋯,$T_n$中选取最优子树$T_α$
