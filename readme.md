# Multivariate-Statistics-Self-Learning

记录多元统计分析的数据、代码、结果。

## 目录
* [**课程教材**](#课程教材)
* [**例题作业代码**](#作业代码)


## 课程教材
《应用多元统计分析》, 高慧璇, 北京大学出版社.
(我没找到清晰的电子版教材, 如果你找到了, 请发一份给我, 感激不尽:)

配套资料：课程网站上有ppt、例题SAS代码和部分习题解答。

推荐阅读:
* [An Introduction to Statistical Learning
with Applications in R, Gareth James](
http://faculty.marshall.usc.edu/gareth-james/ISL/)
* R语言实战(第二版), Robert I. Kabacoff.
* 实用多元统计分析(第六版), Richard A. Johnson.
~~~
说明:教材例题只给了SAS代码, R语言实战是很好的补充, 而且讲得比这本书更偏向于应用;
~~~

## 代码
* [第三章 多元正态总体参数的假设检验](/chapter3) 
    * [多总体均值向量的检验(多元方差分析manova)](chapter3/hypothesis%20test%20for%20multivariable%20manova.R)
    * [一元数据正态性检验的多种方法](chapter3/hypothesis%20test%20for%20multivariable%20manova.R)
    * [多元数据正态性检验的卡方图检验法(P-P plot & Q-Q plot)](chapter3/hypothesis%20test%20for%20multivariable%20manova.R)


* [第四章 回归分析(todo)](/)
  * 我先跳过第四章了, 因为这本书的符号和上学期的回归不一样, 看得好累


* [第五章 判别分析](/chapter5)
    * [距离判别法](/chapter5/discriminant%20analysis_dist.R)
    * [其他方法](/chapter5/discriminant%20analysis_bayes_gendist_fisher.R)
      * 广义平方距离判别法
      * lda(Linear Discriminant Analysis)
      * qda(Quadratic Discriminant Analysis)


* [第六章 聚类分析](/chapter6)
  * [系统聚类(层次聚类)](chapter6/hierarchical%20agglomerative%20clustering.R)
  * [K-means和围绕中心点划分聚类](chapter6/kmeans%20pam.R)
  * [有序样品聚类(最优分割法)](chapter6/ordered%20clustering.R)


* [第七章 主成分分析](chapter7)
  * [主成分分析 指标分类 主成分回归](chapter7/pca.R)
  
* [第八章 因子分析](chapter8)
  * [因子分析](chapter8/fa.R)

* [第九章 对应分析方法](chapter8)
  ##todo* [对应分析](chapter9/fa.R)
