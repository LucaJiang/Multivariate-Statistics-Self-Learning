#第十一章 偏最小二乘回归分析 pls
#例11.2.1 康复俱乐部成员测试偏最小二乘回归分析
#建议参考: https://www.cnblogs.com/payton/p/5253035.html
library(pls)
library(readr)
data <- read_table2("table11.1.txt")
data.sc<-data.frame(scale(data))
x0=as.matrix(data.sc[,1:p])
y0=as.matrix(data.sc[,p+1:q])
plsa=plsr(y0~x0)
summary(plsa)
coef(plsa)
plot(plsa)
#end