#第六章 聚类分析 p243 例6.4.1 16个地区农民生活水平
#系统聚类(层次聚类)

#导入数据----
library(readr)
data=read_csv("table6.7.csv", locale = locale(encoding = "GB2312"))
#数据第一列为地名,2-7列为6个维度
p=6#变量维度(特征数目)


#探索数据----
summary(data)


#标准化----
#标准化使得均值0 方差1
#目的: 均衡各变量的影响;
#原因: 观察数据知, 如果不标准化数据, 距离会极大地被X1影响.
data_sc=scale(data[,1:p+1])#我也不知道为什么这里要从1开始
#其他标准化方法 但效果都不太好
#data_sc=apply(data[,1:p+1],2,function(x){(x-mean(x)/mad(x))})
#data_sc=apply(data[,1:p+1],2,function(x){x/max(x)})
row.names(data_sc)=t(data[,1])
data_=data[,1:p+1]#不标准化
row.names(data_)=t(data[,1])


#判断离群点----
library(mvoutlier)
#基于稳健马氏距离检测离群点
re.outlier=aq.plot(data[,1:p+1])
which(re.outlier$outliers==T)
#可以看出离群点有5个, 还挺多


#进行聚类分析并绘图----
d_meth=c("euclidean","minkowski","canberra")#距离定义
clu.meth=c("ward.D", "ward.D2", "single", "complete",
             "average", "mcquitty", "median","centroid")
for (i in d_meth) {
  #求距离矩阵
  d=dist(data_,i)
  #系统聚类
  for (j in clu.meth) {
    cluster=hclust(d,j)
    fileName=paste(i,j,'hierarchical clustering.png',sep = " ")
    png(filename = fileName)
    main_=paste(j,'Cluster with',i,'distance')
    plot(cluster,hang = -1,main=main_,sub = '',xlab = '城市')
    dev.off()
  }
}
#没有一个和书上结果一样, 醉了


#确定聚类的最佳数目----
#这个数据无法使用, 报错显示无法求逆
library(NbClust)
devAskNewPage(ask=T)
nc=NbClust(data[,1:p+1],distance ="euclidean",method ="average")
barplot(table(nc$best.n[1,]))
#谷歌了一下, 根据我的判断, 这个数据不能被这个函数处理


#确定各类成员----
#在绘图结果中显示分类结果
k_=4
rect.hclust(cluster,k=k_)
#end