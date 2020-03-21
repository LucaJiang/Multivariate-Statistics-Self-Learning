#chapter 5 判别分析 p191 例5.2.2 胃癌鉴别 
#import data----
library(readr)
data=read_csv("table5_2.csv", 
    col_types = cols(g = col_factor(levels = c("1","2", "3"))))
n=15;n1=n2=n3=5;p=4;g=3;


#广义平方距离判别法----
#先验概率相等
#我没看懂书上求d(2|1)的意义, 按自己的理解写的
ans.record=matrix(0,n,g+1)
for (i in 1:g) {#for each group
  s=cov(data[which(data[,p+1]==i),1:p])
  inv.s=solve(s)
  det.s=det(s)
  xbar=colMeans(data[which(data[,p+1]==i),1:p])
  for (j in 1:n) {
    d=as.matrix(data[j,1:p]-xbar)%*%inv.s%*%as.matrix(t(data[j,1:p]-xbar))
    ans.record[j,i]=d+log(det.s)
  }
}
for (j in 1:n) {#for each record find min
  ans.record[j,g+1]=which.min(ans.record[j,1:3])
}
print('广义平方距离错误个数:')# 0
sum(ans.record[,g+1]!=data[,p+1])


#lda ----
#based on Fisher's Theory
#和书上答案一致
library(MASS)
ld.model=lda(g~.,data)
ld.model#系数和书上给出的一致(ld2符号相反)
print('lda错误个数:')# 3
sum(as.numeric(predict(ld.model,data[,1:p])$class)!=data[,p+1])

#qda----
qd.model=qda(g~.,data)
print('qda错误个数:')# 0
sum(as.numeric(predict(qd.model,data[,1:p])$class)!=data[,p+1])
plot(qd.model)


#逐步判别法----
#todo
#我没找到r中对应的函数, 逐步判别的筛选变量本质是降维
#我觉得这里用lasso可能会更合适
#没实现的主要原因是书上矩阵消去变换我没看懂...

#end