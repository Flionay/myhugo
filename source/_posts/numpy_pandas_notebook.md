---
author : "Angyi"
date: 2019-06-09T09:59:58+08:00
draft : false
share : true	# set false to hide share buttons
tags : 
    - pandas
    - numpy
    - python
title : "Numpy and Pandas"
Summary : Numpy and Pandas 莫烦教程笔记
categories : ["python"]
toc : true
---


# Numpy and pandas 
## 学习笔记


```python
#%% [Numpy and Pandas]
import numpy as np 
import pandas as pd 
```


```python
a = np.array([[1,2,3],
              [1,2,3]])
print(a)
print('number of dim:{}'.format(a.ndim))
print('shape of a:{}'.format(a.shape))
print('size of a:{}'.format(a.size))
```

    [[1 2 3]
     [1 2 3]]
    number of dim:2
    shape of a:(2, 3)
    size of a:6


### 创建
用列表创建
定义其中的数字格式 dtype = `np.int/float`


```python
a = np.array([2,12,2],dtype=np.float)
print(a.dtype)
```

    float64



```python
#定义矩阵
matrix = np.array([[1,2,3],[3,4,5]])
print(matrix)
```

    [[1 2 3]
     [3 4 5]]



```python
#零矩阵
a = np.zeros((3,4))
print(a)
```

    [[0. 0. 0. 0.]
     [0. 0. 0. 0.]
     [0. 0. 0. 0.]]



```python
# 1 矩阵
a = np.ones((3,4),dtype=np.int16)
print(a)
```

    [[1 1 1 1]
     [1 1 1 1]
     [1 1 1 1]]



```python
#%%  arange and reshape
a = np.arange(12,160,5).reshape((5,6))
print(a.size)
print(a)
```

    30
    [[ 12  17  22  27  32  37]
     [ 42  47  52  57  62  67]
     [ 72  77  82  87  92  97]
     [102 107 112 117 122 127]
     [132 137 142 147 152 157]]



```python
#%%
a = np.arange(12).reshape((3,4))
print(a)

#%% 
a = np.linspace(1,10,4).reshape((2,2))
print(a)
```

    [[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]
    [[ 1.  4.]
     [ 7. 10.]]


### 基础运算


```python
a =  np.arange(4)
b = np.array([10,20,30,40])
print('b-a={}'.format(b-a))

c = a**2
print(c)

np.sum(c)
a<=3
#%% 矩阵乘法 np.dot(a,b)  各自相乘 *
print('a .* b = {}'.format(a*b))
print('a * b = {}'.format(np.dot(a,b)))


#%% 随机创建
a = np.random.random((2,4))
print(a)
a.max()
a.min()
a.sum(axis =0)
```

 ### 索引


```python
a = np.arange(12).reshape((3,4))
print(a)
print(a.argmin())
print(a.argmax())
print(a.mean())
print(np.average(a))
print(np.median(a))
#print(a.median())
print(a.T)
print(np.clip(a,4,8))
```

    [[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]
    0
    11
    5.5
    5.5
    5.5
    [[ 0  4  8]
     [ 1  5  9]
     [ 2  6 10]
     [ 3  7 11]]
    [[4 4 4 4]
     [4 5 6 7]
     [8 8 8 8]]


### 索引


```python
print(a)

print('a[2] = {}'.format(a[2]))
print('a[2,0]={}'.format(a[2,0]))
print('a[2][0] = {}'.format(a[2][0]))
print('a[2,:] = {}'.format(a[2,:]))
for column in a.T:
    print(column)

#%%
print(a.flat)
print(a.flatten())
for i in a.flat:
    print(i)
```

    [[ 0  1  2  3]
     [ 4  5  6  7]
     [ 8  9 10 11]]
    a[2] = [ 8  9 10 11]
    a[2,0]=8
    a[2][0] = 8
    a[2,:] = [ 8  9 10 11]
    [0 4 8]
    [1 5 9]
    [ 2  6 10]
    [ 3  7 11]
    <numpy.flatiter object at 0x7fa9718bda00>
    [ 0  1  2  3  4  5  6  7  8  9 10 11]
    0
    1
    2
    3
    4
    5
    6
    7
    8
    9
    10
    11


### array 的合并 


```python
a = np.array([1,1,1])
print(a)
b = np.array([2,2,2])
print('a and b_lower = {}'.format(np.vstack((a,b))))
print('a and b_right = {}'.format(np.hstack((a,b))))
```

    [1 1 1]
    a and b_lower = [[1 1 1]
     [2 2 2]]
    a and b_right = [1 1 1 2 2 2]



```python
#%% 增加一个维度
print(a.T)
c = a[np.newaxis,:]
d = b[np.newaxis,:]
print(a[np.newaxis,:])
print(a[:,np.newaxis])
```

    [1 1 1]
    [[1 1 1]]
    [[1]
     [1]
     [1]]



```python
#%% 多个array 的合并
k = np.concatenate((c,d,c,d),axis=0)
print(k)

print('fenge k = {}'.format(np.split(k,2,axis=0)))
# not equal division
print('budengfenge = {}'.format(np.array_split(k,2,axis=1)))
```

    [[1 1 1]
     [2 2 2]
     [1 1 1]
     [2 2 2]]
    fenge k = [array([[1, 1, 1],
           [2, 2, 2]]), array([[1, 1, 1],
           [2, 2, 2]])]
    budengfenge = [array([[1, 1],
           [2, 2],
           [1, 1],
           [2, 2]]), array([[1],
           [2],
           [1],
           [2]])]



```python
#%%  deep copy   and  关联
a = np.array([1,2,3])
c = a.copy()
b = a 
a[1] = 11 
print(a)
print(b)
print(c)
a is b
b is a 
c is a
```

    [ 1 11  3]
    [ 1 11  3]
    [1 2 3]





    False



#  [Pandas] - dataframe


```python
import pandas as pd
s = pd.Series([1,2,'third',np.nan,'five'])
print(s)
```

    0        1
    1        2
    2    third
    3      NaN
    4     five
    dtype: object


### 创建


```python

dates = pd.date_range('20190508',periods=6)
print(dates)
df = pd.DataFrame(np.arange(24).reshape((6,4)),index=dates,columns \
    = ['a','b','c','d'])
print(df)

```

    DatetimeIndex(['2019-05-08', '2019-05-09', '2019-05-10', '2019-05-11',
                   '2019-05-12', '2019-05-13'],
                  dtype='datetime64[ns]', freq='D')
                 a   b   c   d
    2019-05-08   0   1   2   3
    2019-05-09   4   5   6   7
    2019-05-10   8   9  10  11
    2019-05-11  12  13  14  15
    2019-05-12  16  17  18  19
    2019-05-13  20  21  22  23


#### 像这样创建是回报错的，因为创建`pd.DataFrame()` 必须传入`list`
```python
df1 = pd.DataFrame({
        'kobe':24,
        'adele':'3'})
print(df1)
```



```python
#%%  
d = {"kobe":[23],"xiao":[12],"cjen":[2]}
print(d)
df1 = pd.DataFrame(d)
print(df1)
df1.dtypes
df1.index
df1.columns
df1.values
df1.describe
```

    {'kobe': [23], 'xiao': [12], 'cjen': [2]}
       kobe  xiao  cjen
    0    23    12     2





    <bound method NDFrame.describe of    kobe  xiao  cjen
    0    23    12     2>



## pd.datafranme 的索引


```python
date = pd.date_range('20190506',periods=9)
df = pd.DataFrame(np.arange(27).reshape((9,3)),index = date,columns = ['A','B','C'])
print(df)

df.loc['20190508','C']
df.iloc[3,2]
```

                 A   B   C
    2019-05-06   0   1   2
    2019-05-07   3   4   5
    2019-05-08   6   7   8
    2019-05-09   9  10  11
    2019-05-10  12  13  14
    2019-05-11  15  16  17
    2019-05-12  18  19  20
    2019-05-13  21  22  23
    2019-05-14  24  25  26





    11



## 对 nan 的处理


```python
df['D']=np.nan

#%%
print(df)
print(df.dropna(axis=1,how='any'))
df1 = df.dropna(axis=1,how='all')
df1 is df
print(df1)
print(df.fillna(value = 0.5))
#%% 
print(np.any(df.isnull()) == True)
```

                 A   B   C   D
    2019-05-06   0   1   2 NaN
    2019-05-07   3   4   5 NaN
    2019-05-08   6   7   8 NaN
    2019-05-09   9  10  11 NaN
    2019-05-10  12  13  14 NaN
    2019-05-11  15  16  17 NaN
    2019-05-12  18  19  20 NaN
    2019-05-13  21  22  23 NaN
    2019-05-14  24  25  26 NaN
                 A   B   C
    2019-05-06   0   1   2
    2019-05-07   3   4   5
    2019-05-08   6   7   8
    2019-05-09   9  10  11
    2019-05-10  12  13  14
    2019-05-11  15  16  17
    2019-05-12  18  19  20
    2019-05-13  21  22  23
    2019-05-14  24  25  26
                 A   B   C
    2019-05-06   0   1   2
    2019-05-07   3   4   5
    2019-05-08   6   7   8
    2019-05-09   9  10  11
    2019-05-10  12  13  14
    2019-05-11  15  16  17
    2019-05-12  18  19  20
    2019-05-13  21  22  23
    2019-05-14  24  25  26
                 A   B   C    D
    2019-05-06   0   1   2  0.5
    2019-05-07   3   4   5  0.5
    2019-05-08   6   7   8  0.5
    2019-05-09   9  10  11  0.5
    2019-05-10  12  13  14  0.5
    2019-05-11  15  16  17  0.5
    2019-05-12  18  19  20  0.5
    2019-05-13  21  22  23  0.5
    2019-05-14  24  25  26  0.5
    True



### pandas read_csv read_excel read_sql
### pandas  to_csv  to_excel 


```python
data = pd.read_csv('supplier_data.csv')
print(data)
data.to_pickle('sup.pickle')
```

       Supplier Name Invoice Number  Part Number     Cost Purchase Date
    0     Supplier X       001-1001         2341  $500.00       1/20/14
    1     Supplier X       001-1001         2341  $500.00       1/20/14
    2     Supplier X       001-1001         5467  $750.00       1/20/14
    3     Supplier X       001-1001         5467  $750.00       1/20/14
    4     Supplier Y        50-9501         7009  $250.00       1/30/14
    5     Supplier Y        50-9501         7009  $250.00       1/30/14
    6     Supplier Y        50-9505         6650  $125.00        2/3/14
    7     Supplier Y        50-9505         6650  $125.00        2/3/14
    8     Supplier Z       920-4803         3321  $615.00        2/3/14
    9     Supplier Z       920-4804         3321  $615.00       2/10/14
    10    Supplier Z       920-4805         3321  $615.00       2/17/14
    11    Supplier Z       920-4806         3321  $615.00       2/24/14



```python
#%% pandas 合并  横向纵向  不同 columns index
# concatenating
date = pd.date_range('20190506',periods=8)
data2 = pd.DataFrame(np.arange(40).reshape((8,5)),index=date,columns = \
    data.columns)
print(data2)
print(data)
```

                Supplier Name  Invoice Number  Part Number  Cost  Purchase Date
    2019-05-06              0               1            2     3              4
    2019-05-07              5               6            7     8              9
    2019-05-08             10              11           12    13             14
    2019-05-09             15              16           17    18             19
    2019-05-10             20              21           22    23             24
    2019-05-11             25              26           27    28             29
    2019-05-12             30              31           32    33             34
    2019-05-13             35              36           37    38             39
       Supplier Name Invoice Number  Part Number     Cost Purchase Date
    0     Supplier X       001-1001         2341  $500.00       1/20/14
    1     Supplier X       001-1001         2341  $500.00       1/20/14
    2     Supplier X       001-1001         5467  $750.00       1/20/14
    3     Supplier X       001-1001         5467  $750.00       1/20/14
    4     Supplier Y        50-9501         7009  $250.00       1/30/14
    5     Supplier Y        50-9501         7009  $250.00       1/30/14
    6     Supplier Y        50-9505         6650  $125.00        2/3/14
    7     Supplier Y        50-9505         6650  $125.00        2/3/14
    8     Supplier Z       920-4803         3321  $615.00        2/3/14
    9     Supplier Z       920-4804         3321  $615.00       2/10/14
    10    Supplier Z       920-4805         3321  $615.00       2/17/14
    11    Supplier Z       920-4806         3321  $615.00       2/24/14



```python
#%%
# 纵向合并
data_h = pd.concat([data,data2],axis=0,ignore_index=False)
print(data_h)
```

                        Supplier Name Invoice Number  Part Number     Cost  \
    0                      Supplier X       001-1001         2341  $500.00   
    1                      Supplier X       001-1001         2341  $500.00   
    2                      Supplier X       001-1001         5467  $750.00   
    3                      Supplier X       001-1001         5467  $750.00   
    4                      Supplier Y        50-9501         7009  $250.00   
    5                      Supplier Y        50-9501         7009  $250.00   
    6                      Supplier Y        50-9505         6650  $125.00   
    7                      Supplier Y        50-9505         6650  $125.00   
    8                      Supplier Z       920-4803         3321  $615.00   
    9                      Supplier Z       920-4804         3321  $615.00   
    10                     Supplier Z       920-4805         3321  $615.00   
    11                     Supplier Z       920-4806         3321  $615.00   
    2019-05-06 00:00:00             0              1            2        3   
    2019-05-07 00:00:00             5              6            7        8   
    2019-05-08 00:00:00            10             11           12       13   
    2019-05-09 00:00:00            15             16           17       18   
    2019-05-10 00:00:00            20             21           22       23   
    2019-05-11 00:00:00            25             26           27       28   
    2019-05-12 00:00:00            30             31           32       33   
    2019-05-13 00:00:00            35             36           37       38   
    
                        Purchase Date  
    0                         1/20/14  
    1                         1/20/14  
    2                         1/20/14  
    3                         1/20/14  
    4                         1/30/14  
    5                         1/30/14  
    6                          2/3/14  
    7                          2/3/14  
    8                          2/3/14  
    9                         2/10/14  
    10                        2/17/14  
    11                        2/24/14  
    2019-05-06 00:00:00             4  
    2019-05-07 00:00:00             9  
    2019-05-08 00:00:00            14  
    2019-05-09 00:00:00            19  
    2019-05-10 00:00:00            24  
    2019-05-11 00:00:00            29  
    2019-05-12 00:00:00            34  
    2019-05-13 00:00:00            39  



```python
#%%
# 横向合并
date_p = pd.concat([data,data2],axis=1)
print(date_p)
#%%
date_p = pd.concat([data,data2],axis=1,join_axes=[data.index])
print(date_p)
```

                         Supplier Name  Invoice Number  Part Number     Cost  \
    0                       Supplier X        001-1001       2341.0  $500.00   
    1                       Supplier X        001-1001       2341.0  $500.00   
    2                       Supplier X        001-1001       5467.0  $750.00   
    3                       Supplier X        001-1001       5467.0  $750.00   
    4                       Supplier Y         50-9501       7009.0  $250.00   
    5                       Supplier Y         50-9501       7009.0  $250.00   
    6                       Supplier Y         50-9505       6650.0  $125.00   
    7                       Supplier Y         50-9505       6650.0  $125.00   
    8                       Supplier Z        920-4803       3321.0  $615.00   
    9                       Supplier Z        920-4804       3321.0  $615.00   
    10                      Supplier Z        920-4805       3321.0  $615.00   
    11                      Supplier Z        920-4806       3321.0  $615.00   
    2019-05-06 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-07 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-08 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-09 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-10 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-11 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-12 00:00:00            NaN             NaN          NaN      NaN   
    2019-05-13 00:00:00            NaN             NaN          NaN      NaN   
    
                         Purchase Date  Supplier Name  Invoice Number  \
    0                          1/20/14            NaN             NaN   
    1                          1/20/14            NaN             NaN   
    2                          1/20/14            NaN             NaN   
    3                          1/20/14            NaN             NaN   
    4                          1/30/14            NaN             NaN   
    5                          1/30/14            NaN             NaN   
    6                           2/3/14            NaN             NaN   
    7                           2/3/14            NaN             NaN   
    8                           2/3/14            NaN             NaN   
    9                          2/10/14            NaN             NaN   
    10                         2/17/14            NaN             NaN   
    11                         2/24/14            NaN             NaN   
    2019-05-06 00:00:00            NaN            0.0             1.0   
    2019-05-07 00:00:00            NaN            5.0             6.0   
    2019-05-08 00:00:00            NaN           10.0            11.0   
    2019-05-09 00:00:00            NaN           15.0            16.0   
    2019-05-10 00:00:00            NaN           20.0            21.0   
    2019-05-11 00:00:00            NaN           25.0            26.0   
    2019-05-12 00:00:00            NaN           30.0            31.0   
    2019-05-13 00:00:00            NaN           35.0            36.0   
    
                         Part Number  Cost  Purchase Date  
    0                            NaN   NaN            NaN  
    1                            NaN   NaN            NaN  
    2                            NaN   NaN            NaN  
    3                            NaN   NaN            NaN  
    4                            NaN   NaN            NaN  
    5                            NaN   NaN            NaN  
    6                            NaN   NaN            NaN  
    7                            NaN   NaN            NaN  
    8                            NaN   NaN            NaN  
    9                            NaN   NaN            NaN  
    10                           NaN   NaN            NaN  
    11                           NaN   NaN            NaN  
    2019-05-06 00:00:00          2.0   3.0            4.0  
    2019-05-07 00:00:00          7.0   8.0            9.0  
    2019-05-08 00:00:00         12.0  13.0           14.0  
    2019-05-09 00:00:00         17.0  18.0           19.0  
    2019-05-10 00:00:00         22.0  23.0           24.0  
    2019-05-11 00:00:00         27.0  28.0           29.0  
    2019-05-12 00:00:00         32.0  33.0           34.0  
    2019-05-13 00:00:00         37.0  38.0           39.0  
        Supplier Name  Invoice Number  Part Number     Cost  Purchase Date  \
    0      Supplier X        001-1001         2341  $500.00        1/20/14   
    1      Supplier X        001-1001         2341  $500.00        1/20/14   
    2      Supplier X        001-1001         5467  $750.00        1/20/14   
    3      Supplier X        001-1001         5467  $750.00        1/20/14   
    4      Supplier Y         50-9501         7009  $250.00        1/30/14   
    5      Supplier Y         50-9501         7009  $250.00        1/30/14   
    6      Supplier Y         50-9505         6650  $125.00         2/3/14   
    7      Supplier Y         50-9505         6650  $125.00         2/3/14   
    8      Supplier Z        920-4803         3321  $615.00         2/3/14   
    9      Supplier Z        920-4804         3321  $615.00        2/10/14   
    10     Supplier Z        920-4805         3321  $615.00        2/17/14   
    11     Supplier Z        920-4806         3321  $615.00        2/24/14   
    
        Supplier Name  Invoice Number  Part Number  Cost  Purchase Date  
    0             NaN             NaN          NaN   NaN            NaN  
    1             NaN             NaN          NaN   NaN            NaN  
    2             NaN             NaN          NaN   NaN            NaN  
    3             NaN             NaN          NaN   NaN            NaN  
    4             NaN             NaN          NaN   NaN            NaN  
    5             NaN             NaN          NaN   NaN            NaN  
    6             NaN             NaN          NaN   NaN            NaN  
    7             NaN             NaN          NaN   NaN            NaN  
    8             NaN             NaN          NaN   NaN            NaN  
    9             NaN             NaN          NaN   NaN            NaN  
    10            NaN             NaN          NaN   NaN            NaN  
    11            NaN             NaN          NaN   NaN            NaN  



```python
#%%
date_app = data.append(data2,ignore_index = True)

print(date_app)
#%%
```

       Supplier Name Invoice Number  Part Number     Cost Purchase Date
    0     Supplier X       001-1001         2341  $500.00       1/20/14
    1     Supplier X       001-1001         2341  $500.00       1/20/14
    2     Supplier X       001-1001         5467  $750.00       1/20/14
    3     Supplier X       001-1001         5467  $750.00       1/20/14
    4     Supplier Y        50-9501         7009  $250.00       1/30/14
    5     Supplier Y        50-9501         7009  $250.00       1/30/14
    6     Supplier Y        50-9505         6650  $125.00        2/3/14
    7     Supplier Y        50-9505         6650  $125.00        2/3/14
    8     Supplier Z       920-4803         3321  $615.00        2/3/14
    9     Supplier Z       920-4804         3321  $615.00       2/10/14
    10    Supplier Z       920-4805         3321  $615.00       2/17/14
    11    Supplier Z       920-4806         3321  $615.00       2/24/14
    12             0              1            2        3             4
    13             5              6            7        8             9
    14            10             11           12       13            14
    15            15             16           17       18            19
    16            20             21           22       23            24
    17            25             26           27       28            29
    18            30             31           32       33            34
    19            35             36           37       38            39



```python
s1 = pd.Series(np.arange(5),index = data2.columns)
print(s1)
date_app = date_app.append(s1,ignore_index = True)
print(date_app)

# merge
# 更强大的按照columns 合并的函数
# #pd.merge(left,right,on = ['key'],how = 'outer')
# how = ['left','right','inner','outer']  indicater = True

#%%
```

    Supplier Name     0
    Invoice Number    1
    Part Number       2
    Cost              3
    Purchase Date     4
    dtype: int64
       Supplier Name Invoice Number  Part Number     Cost Purchase Date
    0     Supplier X       001-1001         2341  $500.00       1/20/14
    1     Supplier X       001-1001         2341  $500.00       1/20/14
    2     Supplier X       001-1001         5467  $750.00       1/20/14
    3     Supplier X       001-1001         5467  $750.00       1/20/14
    4     Supplier Y        50-9501         7009  $250.00       1/30/14
    5     Supplier Y        50-9501         7009  $250.00       1/30/14
    6     Supplier Y        50-9505         6650  $125.00        2/3/14
    7     Supplier Y        50-9505         6650  $125.00        2/3/14
    8     Supplier Z       920-4803         3321  $615.00        2/3/14
    9     Supplier Z       920-4804         3321  $615.00       2/10/14
    10    Supplier Z       920-4805         3321  $615.00       2/17/14
    11    Supplier Z       920-4806         3321  $615.00       2/24/14
    12             0              1            2        3             4
    13             5              6            7        8             9
    14            10             11           12       13            14
    15            15             16           17       18            19
    16            20             21           22       23            24
    17            25             26           27       28            29
    18            30             31           32       33            34
    19            35             36           37       38            39
    20             0              1            2        3             4
    ['A', 'B', 'C', 'D']



```python

```
