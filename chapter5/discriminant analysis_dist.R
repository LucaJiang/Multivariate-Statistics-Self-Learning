# chapter5 判别分析 p182 例5.1.1 距离判别
#问题：给定5个含钾盐泉特征数值和5个含钠盐泉特征数值，对8个未知盐泉含钾性进行判断
#import data----
library(readr)
data=read_csv("table5_1.csv",na ="null")
data[1:5,5]=1;data[6:10,5]=2;#change format
p=4#特征数目, 数据维度
n1=n2=5#每组数据个数
n=10;#训练集样本数
test.n=8#测试集样本数
group.1=data[which(data[,p+1]=='1'),1:p]
group.2=data[which(data[,p+1]=='2'),1:p]
group.unk=data[is.na(data[,p+1]),1:p]

#!!!题目中说的两组间的平方距离...不太清楚指的是啥

#假设检验H_0: \miu^(1)=\miu^(2)----
x=as.factor(as.matrix(data[1:n,p+1]))
y=as.matrix(data[1:n,1:p])
test.maov=manova(y~x)
summary(test.maov)#总体
#求出F=14.46和书上一致
summary.aov(test.maov)#每个特征单独分析

#错误的尝试
#假设方差不相等，求线性判别函数----
#这里不能假设方差不等，距离除了线性判别函数还有一项带方差
#算出的答案很诡异。。。
#y1=a1x+b1
x1.bar=colMeans(group.1)
A1=matrix(0,p,p)
for (i in 1:n1) {
  A1=A1+t(as.matrix(group.1[i,]-x1.bar))%*%as.matrix(group.1[i,]-x1.bar)
}
s1=A1/(n1-1)#和cov(group.1)求出来的一致
a1=solve(s1)%*%x1.bar
b1=-0.5*t(x1.bar)%*%solve(s1)%*%x1.bar
#y2=a2x+b2
x2.bar=colMeans(group.2)
s2=cov(group.2)
a2=solve(s2)%*%x2.bar
b2=-0.5*t(x2.bar)%*%solve(s2)%*%x2.bar
#discriminant
dist.record=matrix(0,n+test.n,3)
for (i in 1:(n+test.n)) {
  dist.record[i,1]=as.matrix(data[i,1:p])%*%a1+b1
  dist.record[i,2]=as.matrix(data[i,1:p])%*%a2+b2
  dist.record[i,3]=((dist.record[i,1]-dist.record[i,2])<0)+1
}

#假设方差相等，求线性判别函数----
#虽然线性判别函数不一样，但是结果和课本一致
s=cov(rbind(group.1,group.2))
a1=solve(s)%*%x1.bar
b1=-0.5*t(x1.bar)%*%solve(s)%*%x1.bar
a2=solve(s)%*%x2.bar
b2=-0.5*t(x2.bar)%*%solve(s)%*%x2.bar
dist.record=matrix(0,n+test.n,3)
for (i in 1:(n+test.n)) {
  dist.record[i,1]=as.matrix(data[i,1:p])%*%a1+b1
  dist.record[i,2]=as.matrix(data[i,1:p])%*%a2+b2
  dist.record[i,3]=((dist.record[i,1]-dist.record[i,2])<0)+1
}#u1s1 我觉得这个教材解释得很不清楚


#lda which based on Fisher's Theory----
#结果和课本一致
library(MASS)
ld.model=lda(g~.,data)
predict(ld.model,data[,1:p])$class
plot(ld.model)
#end