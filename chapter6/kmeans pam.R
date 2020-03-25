#第六章 聚类分析 p252 例6.5.3 16个地区农民生活水平
#K-means PAM

#导入数据----
library(readr)
data=read_csv("table6.7.csv", locale = locale(encoding = "GB2312"))
#数据第一列为地名,2-7列为6个维度
p=6#变量维度(特征数目)


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


# Plot function for within groups sum of squares by number of clusters----
wssplot <- function(data, nc=15, seed=1234){
  wss <- (nrow(data)-1)*sum(apply(data,2,var))
  for (i in 2:nc){
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
  plot(1:nc, wss, type="b", xlab="Number of Clusters",
       ylab="Within groups sum of squares")}


#K-means聚类----
wssplot(data_sc)#由图可得推荐k=4
k=4
set.seed(0)
cluster=kmeans(data_sc,k,nstart = 10)
table(data[,1],cluster$cluster)#聚类结果
plot(cluster$cluster,cex=0.1,pch=19,xlab = "城市",
     ylab = "类别",main="K-means聚类")
text(cluster$cluster,data[,1], cex=0.7)


#PAM(围绕中心点的划分)----
library(cluster)
set.seed(0)
clu.pam=pam(data_sc,k=4)
clusplot(clu.pam,main = "Bivariate Cluster Plot")
#end