#第六章 聚类分析 p255 有序样品聚类 例6.6.1 儿童发育阶段划分
#最优分割法
#数据----
n=11
data=c(9.3,1.8,1.9,1.7,1.5,1.3,1.4,2.0,1.9,2.3,2.1)
index=1:n
datatable=t(rbind(index,data))

#运行ocluster.R获得函数----
source("ocluster.R")

#有序聚类----
loss.mat=ocluster(datatable,11)
plot(loss.mat[nrow(loss.mat),], type="b", xlab="分类数k",
     ylab="损失函数L[P(n,k)]",main="损失函数随k变化图")
#选择分类数为4
temp=ocluster(datatable,4)
#显示结果和教材中一致
#end