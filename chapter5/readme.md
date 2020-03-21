# 第五章 判别分析

教材5.1节 距离判别 例5.1.1实现 及 
教材5.2节 贝叶斯判别法及广义平方判别法 例5.2.2实现.

文件夹内容说明:

* .RData文件为运行结果;
* img文件为结果图;
* table5.1为教材p182例5.1.1：给定5个含钾盐泉特征数值和5个含钠盐泉特征数值，对8个未知盐泉含钾性进行判断;
* table5.2为教材p191例5.2.2胃癌鉴别数据;
* discriminant analysis_dist.R为使用距离判别法对table5.1未知盐泉含钾性进行判断;
* discriminant analysis_bayes_gendist_fisher.R包含:
    * 广义平方距离判别法;
    * lda(Linear Discriminant Analysis);
    * qda(Quadratic Discriminant Analysis).
   

## 绘图结果：
lda结果:

![](img/yanquan_lda.png)