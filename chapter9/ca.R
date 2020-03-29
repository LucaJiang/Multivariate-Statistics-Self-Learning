#第九章 对应分析 p335~341
#例9.3.1 哲学博士学位的对应分析
#例9.3.2 农村居民消费的对应分析

#9.3.1----
library(ca)
library(readr)
#更改data格式
data_=read_table2("table9.1.txt")
data=as.data.frame(data_[,-1],col.names=colnames(data_)[-1])
row.names(data) = as.matrix(data_[,1])
#对应分析
data.ca=ca(data)
data.ca
plot.ca(data.ca,main='行点和列点散布图')

#9.3.2----
#更改data格式
data_=read_table2("table9.2.txt")
data=as.data.frame(data_[,-1],col.names=colnames(data_)[-1])
row.names(data) = as.matrix(data_[,1])
#对应分析
data.ca=ca(data)
data.ca
plot.ca(data.ca,main='行点和列点散布图',xlim=c(-.5,.5),ylim=c(-.2,.4))
#end