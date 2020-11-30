# Multivariate-Statistics-Self-Learning

记录多元统计分析的数据、代码、结果。

## 目录
* [**课程教材**](#课程教材)
* [**例题作业代码**](#代码)
* [**平时作业**](#平时作业)
* [**期末大作业**](#期末大作业)


## 课程教材
《应用多元统计分析》, 高慧璇, 北京大学出版社.

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


* 第四章 回归分析
  * 我跳过了第四章, 回归分析是另一门课程的内容.


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

* [第九章 对应分析方法](chapter9)
  * [对应分析](chapter9/ca.R)

* [第十章 典型相关分析](chapter10)
  * [典型相关分析](chapter10/ca.R)
  
* [第十一章 偏最小二乘回归分析](chapter11)
  * [偏最小二乘回归分析](chapter11/pls.R)
  
## 平时作业   
平时作业已全部上传到我的[博客](https://lucajiang.github.io/)里 
在这个页面：https://lucajiang.github.io/2020/11/27/Multivariate-Statistics-HW/
  
## 期末大作业 

* [Kaggle 蘑菇数据集：辨别蘑菇是否可食用](proj)

可以在此处围观大作业的pdf文件：https://lucajiang.github.io/2020/11/16/Kaggle-Mushroom-Dataset/

## 最后

很有意思的是, 2017级多元统计课程并没有选用这本书作为教材, 而是选用了Modern Multivariate Statistical Techniques--
一本介绍现代多元统计的英文书作为教材. 课程内容包括: 主成分分析 线性判别分析 决策树 聚类分析 支持向量机 集成学习等.

以及, 感谢star本项目的同学给我的支持. 欢迎大家顺手去逛逛我的个人博客.

大作业使用的模型包括: 主成分回归、线性判别分析、LASSO 回归、逐步回归、决策树（CART、C4.5、C5.0）、
随机森林、XGBoost、kNN、SVM 、NN、RIPPER 和 PART（两个类似决策树的模型，虽然很多教材都没涉及，但尤其适合我选择的数据集）. 涉及了数据的探索性分析,预处理,建模等内容. 如果感兴趣, 可以看看.

附 Modern Multivariate Statistical Techniques 教材主页的网址: [https://astro.temple.edu/~alan/MMST/](https://astro.temple.edu/~alan/MMST/)
