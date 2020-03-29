#第十章 典型相关分析 canonical correlation analysis
#例10.2.1 矿区下部矿的典型相关分析
#例10.3.1 康复俱乐部成员测试的冗余分析

#10.2.1----
library(readr)
p=q=2;n=27
options(digits = 4)
data=read_table2("table10.1.txt")
data_sc=scale(data)
x=data_sc[,1:p]
y=data_sc[,p+1:q]
#典型相关分析
cca=cancor(x,y)
cca
#计算得分
u=x%*%cca$xcoef
v=y%*%cca$ycoef
plot(u[,1],v[,1],main = '第一对样本典型变量得分图',xlab = 'u',ylab = 'v')
plot(u[,2],v[,2],main = '第二对样本典型变量得分图',xlab = 'u',ylab = 'v')
#假设检验
source('corcoef.test.R')
corcoef.test(cca$cor,n,p,q)
#end1

#10.3.1----
data=read_table2("table10.2.txt")
n=20;p=q=3
data_sc=scale(data)
x=data_sc[,1:p]
y=data_sc[,p+1:q]
#典型相关分析
cca=cancor(x,y)
cca
#假设检验
source('corcoef.test.R')
corcoef.test(cca$cor,n,p,q,alpha = .1)
#计算得分
u=x%*%cca$xcoef
v=y%*%cca$ycoef
plot(u[,1],v[,1],main = '第一对样本典型变量得分图',xlab = 'u',ylab = 'v')
plot(u[,2],v[,2],main = '第二对样本典型变量得分图',xlab = 'u',ylab = 'v')

#另一种方法
#参考:https://blog.csdn.net/qq_38854576/article/details/83024468
library(vegan)
fc=data[,1:p]#读取解释变量数据
sp=data[,p+1:q]#读取响应变量数据
spp=decostand(sp,method = "hellinger")#对响应变量做转化
fcc=log10(fc)#对解释变量做转化
uu=rda(spp~.,fcc)#RDA分析
summary(uu)  #查看分析结果
plot(uu,main='冗余分析')
#end2