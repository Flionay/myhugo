---
title: 数值分析与Matlab
author: Angyi
top: true
cover: true
toc: true
mathjax: true
date: 2020-05-21 13:21:55
img:
coverImg: https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/5.jpg
password:
summary: 数值分析课程章节回顾，主要方法Matlab实现。
tags:
    - Matlab
    - 数值分析
categories: Matlab
---
# 数值分析期末总结-----数值计算与Matlab

> 参考《数值分析及其Matlab试验（第二版）》姜剑飞 -清华大学出版社

## 第一章 科学计算简介

### 研究对象

在解决现代工程技术问题是，常常需要首先建立问题的数学模型，然后合理的设计问题的算法，并通过计算机计算，获得问题的答案。数值分析正是以此为研究对象。

但是我们必须认识到，计算机的能力也是有限的，我们需要设计其能够接受的算法，用计算机能够理解的语言进行刻画，同时考虑计算量的复杂性，以及结果的准确性。

计算机算法主要包含**数值算法**、**非数值算法**和**软计算方法**三类。数值算法主要指与连续数学模型有关的算法，如数值线性代数、方程求解、数值逼近、数值微积分、微分方程数值解和最优化计算方法等;非数值算法主要指与离散数学模型有关的算法,如排序、搜索、分类、图论算法等;软计算方法是近来发展的不确定性算法的总称，包括随机模拟、神经网络计算、模糊逻辑、遗传算法、模拟退火算法和DNA算法等。

数值算法有以下几个显著特点：**有穷性，数值性，近似性。**

### 误差分析

计算机离散本质决定了它无法表达数学上类似微分，积分这种无穷极限的思想，它们之间必然会存在误差，那么怎么估计误差，判断计算结果的有效性就成了数值分析开篇我们必须研究的内容。

> 1. 从实际问题中抽象出数学模型。  ——模型误差
> 2. 通过测量得到模型中参数的值。  ——观测误差
> 3. 求近似解。                                     —— 方法误差
> 4. 机器字长有限。                              —— 舍入误差

**数值算法设计的一些注意事项：**

1. 要保证算法具有收敛性和较高的收敛速度
2. 保证算法具有数值稳定性
3. 小心处理病态问题
    - 避免相近的数相减
    - 注意大数吃小数
    - 避免死循环，节省内存空间
    - 不要加判断实数是否相等的判断
    - 尽量使用双精度数值长度，避免中间打印输出。

## 第二章 数据建模---差值与拟合

> 已知一批数据坐标点$(x_1,y_1)(x_2,y_2)...(x_n,y_n)$,而这批数据的规律未知，我们希望从某类函数出发（如多项式函数，样条函数等），求的一个函数$\phi(x)$作为这组数据规律的近似，这类问题称之为数据建模。

**插值与拟合**

==插值方法==，要求所求函数$\phi(x)$严格遵从数据$(x_1,y_1)(x_2,y_2)...(x_n,y_n)$

==拟合方法==，允许函数$\phi(x)$在数据点上有误差，但是要求达到某种误差指标最小化。



### 多项式插值

#### 1. 拉格朗日插值函数

$$L_n(x) = \sum_{i=0}^n l_i(x)y_i$$

其中$l_{i}(x)=\prod_{j=0 \atop j\neq i}^n \frac{x-x_{j}}{x_{i}-x_{j}}$ 是n次拉格朗日基函数。

拉格朗日插值余项表明了拉格朗日插值的结果的截断误差，这里省略，具体用到详查。

```matlab
function yy = nalagr(x,y,xx)
% 用途：拉格朗日插值法数值求解
%(x,y)为已知点向量，xx是插值点，yy为插值结果
m = length(x);
n = length(y);

if m～= n 
	error('length of x must be the same as y');
end
	
	
s = 0; 
for i = 1:n
	t = ones(1,length(xx));
	for j = [1:i-1,i+1,n]:
		t = t.*(xx-x(j))/(x(i)-x(j));
	end
	s = s+ t* y(i);
	
end
yy = s;
```



#### 2. 牛顿插值

拉格朗日插值基函数来源于每一个点，所以每增加一个节点就要重新计算插值函数，而牛顿插值函数引入差商概念，每增加一个节点只需要多增加一项，揭示了不同拉格朗日插值多项式的内在联系。

```matlab
function table = newton_table(X,Y,n)
    % 求牛顿差商表以及n次插值多项式
    
    m = length(X);
    init_table = zeros(m,n+1);
    init_table(:,1)=Y;
    
    temp = Y;
    for i = 1:n
        h = zeros(m,1);
        for j = i+1:m
            
            h(j,1)=(temp(j)-temp(j-1))/(X(j)-X(j-i));
            
            
        end
        temp = h;
        init_table(:,i+1) = temp;
        
    end
    table = init_table;
end
```
```matlab
function [expressions,w] = expression(X,table,n)
%由差商表计算牛顿插值多项式

% 获取对角线
dui = diag(table);
syms x
temp = 1;
expressions = 0;
for i =1: n
    expressions = expressions+dui(i)*temp;
    temp = temp*(x-X(i));
    
end
w = temp*(x-X(end));
end

```
```matlab
X = [0.4,0.55,0.65,0.8,0.90,1.05];
y_lnx = [0.41075,0.57815,0.69675,0.88811,1.02652,1.25382];
table = newton_table(X,y_lnx,5) %求牛顿差商表
[newton_expression,w] = expression(X,table,4)% 求牛顿插值多项式，返回表达式以及f[x,x0,...,xn]
sym x
% 代入插值坐标点
y = subs(newton_expression,x,0.596)
% 计算截断误差
error = abs(subs(w,x,0.596)*table(end,end))  %| f[x,x0,...,xn]*w(n+1)|
scatter(X,y_lnx)
hold on 
scatter(0.596,y,'r')
legend('源数据','插值点')
```

#### 3. 样条插值

从拉格朗日插值余项公式来看，增加节点对提高精度是有利的，但实际情况并非如此，高阶插值产生震荡的现象称之为龙格现象。避免出现龙格现象的最简单方法就是分段插值，但是分段插值具有不光滑性，而埃尔米特插值原理可以得到具有光滑性的分段插值，但是需要我们知道函数一阶导数值，而在实际应用中一般未知，也没必要固定这个值。

在实际应用中使用更加广泛的插值法为——三次样条插值。

**算法总结(自然边界条件)**

假定有n+1个数据节点$(x_0,y_0),(x_1,y_1),(x_2,y_2)...(x_n,y_n)$

1. 计算步长$h_i = x_{i+1}-x_i (i=0,1...n-1)$

2. 将数据节点和指定的端点条件带入矩阵方程。

3. 解矩阵方程，求得二次微分值$m_i$。

4. 计算样条曲线的系数：

   $a_i = y_i$

   $b_i = \frac{y_{i+q}-y_i}{h_i}-\frac{h_im_i}{2}-\frac{h_i(m_{i+1}-m_i)}{6}$

   $c_i = m_i/2$

   $d_i = \frac{m{i+1}-m_i}{6h_i}$

5. 在每个子区间$[x_i,x_{i+1}]$,$g_i(x)=a_i+b_i(x-x_i)+c_i(x-x_i)^2+d_i(x-x_i)^3$

```matlab

function yy = Spline3(x, y, xx)
%%
% 输入
% 
% x已知点横坐标
% y已知点纵坐标
% xx插值点横坐标

%输出
%   yy 插值点函数值
% %%}

n = length(x);
a = y(1 : end - 1); % 样条曲线系数a
b = zeros(n - 1, 1);
d = zeros(n - 1, 1);
dx = diff(x);%差分步长x(i+1）-x(i)
dy = diff(y);%差分步长y(i+1）-y(i)
A = zeros(n);
B = zeros(n, 1);
A(1, 1) = 1;
A(n, n) = 1;
for i = 2 : n - 1
    A(i, i - 1) = dx(i - 1);
    A(i, i) = 2*(dx(i - 1) + dx(i));
    A(i, i + 1) = dx(i);
    B(i) = 3*(dy(i) / dx(i) - dy(i - 1) / dx(i - 1));
end
c = A \ B;%样条曲线系数c
for i = 1 : n - 1
    d(i) = (c(i + 1) - c(i)) / (3 * dx(i));%%样条曲线系数d
    b(i) = dy(i) / dx(i) - dx(i)*(2*c(i) + c(i + 1)) / 3;%样条曲线系数b
end
[mm, nn] = size(xx);
yy = zeros(mm, nn);
for i = 1 : mm*nn
    for ii = 1 : n - 1   %创建子区间 
        if xx(i) >= x(ii) && xx(i) < x(ii + 1)
            j = ii;
            break;
        elseif xx(i) == x(n)
            j = n - 1;
        end
    end
    yy(i) = a(j) + b(j)*(xx(i) - x(j)) + c(j)*(xx(i) - x(j))^2 + d(j)*(xx(i) - x(j))^3;% 在每个子区间计算函数值
end
end

```

```matlab
clear; clc;
x = 0 :0.5: 10;
y = sin(x);
xx = 0 : 0.2 : 10;
yy= Spline3(x, y, xx);
plot(x, y, '-r', xx, yy, 'ob')
legend('源数据','插值点')
```

### 最小二乘拟合

```matlab
function [ f ] = my_polyfit( x,y,n )

[~,k]=size(x);
X0=zeros(n+1,k);
for k0=1:k          
    for n0=1:n+1
        X0(n0,k0)=x(k0)^(n+1-n0);
    end
end
X=X0';
f=(X'*X)\X'*y';

end


```



```Matlab
%% polyfit

clear
clc


x=[2,4,5,6,6.8,7.5,9,12,13.3,15];
y=[-10,-6.9,-4.2,-2,0,2.1,3,5.2,6.4,4.5];

f_a = my_polyfit(x,y,2);

f = polyval(f_a,x)

f_b = polyfit(x,y,2);

f1 = polyval(f_b,x);

plot(x,f,'r',x,f1,'--');

hold on

scatter(x,y,'o','b');

legend1 = legend('mypolyfit','polyfit','observe')

set(legend1,...

  'Position',[0.69125744047619 0.327388285909847 0.0899553571428571 0.164271047227926],...

  'FontSize',20);
```

![截屏2020-05-17下午10.37.32](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/截屏2020-05-17%20下午10.37.32.png)

## 第三章 数值代数——解线性方程组的直接方法

###  高斯消去法

高斯消去法是我们最常用的，其理论基础就是线性代数的初等变换，想到这里脑海可能会浮现一堆名词，增广矩阵，解的存在性定理和判定，系数矩阵的秩，增广矩阵的秩等。相对于克莱姆法则，计算量从`(n+2)!`减少到$n^3$数量级，计算量过大的问题已经得到了根本解决。

### 选列主元高斯消去法
高斯消去法的缺陷是一旦有主元素为0时，计算就会不能进行，计算过程数值不稳定，导致高斯消去法的过程不可靠。

为了解决这一问题，采用列主元高斯消去法，其思想就是选择剩余行中绝对值较大的主元，进行行对换，再进行消元法。

### 三对角线性方程组的追赶法

![三对角方程](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/nEWr4s.png)


解决这类方程用追赶法：
```matlab
function x = TDMAsolver(a,b,c,d)
%a b c 三对角矩阵的对角向量 d 右边向量
n = length(d); % 行
 
% 修改第一行系数
c(1) = c(1) / b(1);    
d(1) = d(1) / b(1);   
 
for i = 2:n-1
    temp = b(i) - a(i) * c(i-1);
    c(i) = c(i) / temp;
    d(i) = (d(i) - a(i) * d(i-1))/temp;
end
 
d(n) = (d(n) - a(n-1) * d(n-1))/( b(n) - a(n-1) * c(n-1));
 
%
x(n) = d(n);
for i = n-1:-1:1
    x(i) = d(i) - c(i) * x(i + 1);
end

```

```matlab
a = [2,2,1];
c = [1,1,1]
b = repmat(3,4,1);
f = [2,1,2,-4]
x = TDMAsolver(a,b,c,f)

```

### 直接三角分解法

对于一个矩阵实施一次行变换就相当于左乘一个相应的初等矩阵。将高斯消去法用矩阵表示就可以写成这样：

$$P_3P_2P_1(A,b) = (U,y)$$

令 $P = P_3P_2P_1$   则 $PA = U , Pb = y$,由于P可逆，令$L = P^{-1}$  则 $A = LU$



####  LU分解

如果我们能直接将系数矩阵分解成LU，

$$Ax = b$$

$$LUx = b$$

则可以推出： $Ly = b, Ux = y $, 这样就转换为解两个三角形方程，而解这种方程只需要回带过程，只有$n^2$计算量。而且对于简单的矩阵熟练的话，手写LU分解也是很快的。



#### 解对称正定方程组的平方根法

 如果系数矩阵对称且正定（顺序主子式>0）那么一定可以分解为：

$$ A = L L^T$$  其中L 为下三角矩阵。

但是平方根法的运算中包含开方运算，会影响计算速度和精度。因此出现了改进的平方根法，对矩阵A做分解$A = LDL^{T}$

``` 
[L,U,P] = lu(A) % 选列主元LU分解
R= chol(X)      % 平方根分解
[Q,R] = qr(A)    % 正交三角分解
[U,S,V] = svd(A) % SVD 分解
```

### 范数



## 第四章  解线性方程组的迭代法


#### 1. 雅可比迭代

#### 2. 高斯塞德尔迭代

![image-20200520111726843](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/image-20200520111726843.png)

![image-20200520111629012](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/image-20200520111629012.png)

#### 3. 超松弛迭代

![超松弛](https://cdn.jsdelivr.net/gh/Flionay/pic_bed@master/Upic/202005/zaMDdQ.png)

## 第五章 数值微积分

能找到fx原函数的定积分我们一般使用牛顿莱布尼茨公式进行计算，但是有很多函数无法找到原函数，我们同样也需要计算定积分的解，就要依靠数值计算方法。

#### 1. 梯形法

```matlab
function t=natrapz(fnamera,a,b,n)
% 用途：定步长梯形法求函数的积分
% 格式：t=natrapz (fname，a，b,n) 其中，fname是被积函数，a,b分别为下上限，n为等分数 
h= (b-a)/n;
fa = fname(a);
fb = fname(b);
f = fname(a+h:h:b-h+0.001*h);
t = h*(0.5*(fa+fb)+sum(f));
```
#### 1. 龙贝格求积
```matlab
function t=naromberg(fname,a,b,e)
% 用途:龙贝格法求函数的积分

% 格式:t=naromberg(fname,a, b,e)。其中,fname 是被积函数,a,b分别为下上限,e为精度(默认le-4)

if nargin<4,e=le-4;end
i=1;j=1; h=b-a;

T(i,1)=h/2*(fname (a)+fname (b));
T(i+1,1)=T(i,1)/2+sum(fname(a+h/2:h:b-h/2+0.001*h))*h/2;
T(i+1,j+1)=4^j*T(i+1,j)/(4^j-1)-T(1, j)/(4^j-1);
while abs(T(i+1,i+1)-T(i,i))>e
	i=i+1;h=h/2;

	T(i+1,1)=T(i,1)/2+sum(fname (a+h/2:h:b-h/2+0.001*h))* h/2;
	for j=1:1
		T(i+1,+1)=4^j*T(i+1,j)/(4^j-1)-T(i,j)/(4^j-1);
	end
end
T
t = T(i+1,j+1);
```

### 3. 辛普森求积

```matlab
function [result] = ComplexSimpson(x_LowBound, x_Up_Bound,n)
% simpson求积公式
% Inputs:
%        x_LowBound:积分区间下界
%        x_UpBound :积分区间上界
%        n         ：等分数量,需要为2n等分，即节点个数必须满足2n+1
% Outputs:
%        result    : 复化Simpson积分结果

% 判断积分区间个数是否是2的倍数，满足则进行计算，否则打印提示
if mod(n,2) == 0
    % 获取步长h
    step_length = (x_Up_Bound - LowBound)/n;
    %累积计算
    result = 0;
    for i = 1:2:n-1
        result = result + CalcuFunctionValue(x_LowBound+step_length*(i-1))...
                 +4*CalcuFunctionValue(x_LowBound+step_length*i)...
                 +CalcuFunctionValue(x_LowBound+step_length*(i+1));
    end % 循环结束
    result = result*step_length/6;
else
    print('等分区间数错误！');
end % if判断结束
end % 函数结束
```


## 解非线性方程的数值解法
迭代法的原理是“不动点原理”，设方程$f(x) = 0$  在$x_0$附近有且仅有一个根，那么可以将前面的这个式子变形为$x = g(x)$


### 牛顿迭代法
```matlab
function x = nanewton(fname,dfname,x0,e,N)
% 用途：牛顿迭代法解非线性方程 f(x) = 0
% 格式 fname和dfname分别表示f及其导数的函数句柄，x0为初值，e是精度要求，x返回数值解 N为设置迭代次数
if nargin < 5, N = 500; end
if nargin < 4, e = 1e-4; end
x = x0, x0 = x+2*e ; k = 0;
while abs(x0-x)>e&k<N,
	k = k+1;
	x0 = x;
	x = x0-fname(x0)/dfname(x0);
	disp(x)
end
if k==N,warning("达到迭代次数上限")；end
```






