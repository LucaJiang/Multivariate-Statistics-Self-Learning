#P83-85 多总体均值向量的检验 例3.3.2
#习题三 3-13
# import data ----
table3_3 <- read_delim("table3.3.txt", "\t", escape_double = FALSE, trim_ws = TRUE)
data=table3_3

#问题一: 三个组(g=1,2,3)的四项指标之间有无显著差异 ----
##n_1=n_2=n_3=20, n=60, p=4, k=3
##H_0: \miu^(1)=\miu^(2)=\miu^(3) vs H_1: \miu^(1) \miu^(2) \miu^(3)至少有一对不相等
##似然比统计量\Lambda~\Lambda(p,n-k,k-1)
##F~F(2p,2(n-p+1))
n=60; p=4; k=3;
x_bar=as.matrix(aggregate(data[,1:4],by=data[,5],FUN=mean))[,2:5]#group mean
X_bar=colMeans(x_bar)#total mean
A=matrix(0,p,p);T_=A #单独T相当于TRUE, 所以加_
B=A;
for (i in 1:k) {
  index=which(data[,p+1]==i)
  # 组内离差阵
  A=A+t(as.matrix(data[index,1:p]))%*%as.matrix(data[index,1:p])-
    length(index)*x_bar[i,]%*%t(x_bar[i,])
  
  # 组间离差阵
  B=B+(x_bar[i,]-X_bar)%*%t(x_bar[i,]-X_bar)*length(index)
  
  # 总离差阵
  temp=as.matrix(data[index,1:p]-matrix(1,length(index),1)%*%t(X_bar))
  T_i=matrix(0,p,p)
  for (j in 1:length(index)){
    T_i=T_i+temp[j,]%*%t(temp[j,])
  }
  T_=T_+T_i
}
Lambda=det(A)/det(T_)
F_=(n-k-p+1)*(1-sqrt(Lambda))/p/sqrt(Lambda)
pval=pf(F_,2*p,2*(n-p+1),lower.tail = F)


#问题二: 三个组指标之间的差异具体由哪几项指标引起 ----
pval_each=vector(length = p)
for (i in 1:p) {
  f=(T_[i,i]-A[i,i])/(k-1)/A[i,i]*(n-k)
  pval_each[i]=pf(f,k-1,n-k,lower.tail = F)
}
pval_each #pval for each variable

##多元方差分析
y=as.matrix(data[,1:4])
fit=manova(y~as.factor(as.matrix(data[,5])))#需要转换为因子变量才能用作分组
summary(fit)
summary.aov(fit)
# 注意manova使用Pillai-Bartlett Trace (also known as Pillai’s trace)
# 而不是威尔克斯LAMBDA统计量, 所以结果有少许不同!
# ref: https://gaopinghuang0.github.io/2017/11/20/MANOVA-notes-and-R-code

# 问题三: 对每个分量检验是否是一元正态 ----
##qqnorm
for (i in 1:k) {
  x=as.matrix(data[,i])
  y=(x-mean(x))/sd(x)
  fileName=paste('X',i,'Q-Qplot.png',sep = "")
  png(filename = fileName)
  qqnorm(y,main=paste('X',i,'Q-Q Plot'))
  qqline(y)
  dev.off()
}
##test
library(goftest)
ks.pval=vector(length = k)#init
ad.pval=ks.pval
cvm.pval=ks.pval
shapiro.pval=ks.pval
for (i in 1:k) {
  x=as.matrix(data[,i])
  y=(x-mean(x))/sd(x)
  test=ks.test(y,"pnorm");ks.pval[i]=test$p.value
  test=ad.test(y,null='pnorm');ad.pval[i]=test$p.value
  test=cvm.test(y,null='pnorm');cvm.pval[i]=test$p.value
  test=shapiro.test(y);shapiro.pval[i]=test$p.value
}
ks.pval
ad.pval
cvm.pval
shapiro.pval

#问题四: 利用\chi-squre图检验法对三组数据分别检验是否来自四元正态分布
for (i in 1:k) {
  index=which(data[,p+1]==i)
  ni=length(index)#第i组数量n_i
  s=cov(data[index,1:p])
  invs=solve(s)
  d=vector(length = ni)#马氏距离
  chi2t=d#分位数
  pt=d;#概率
  H=d;#value of cdf
  for (j in 1:ni) { #计算马氏距离和分位数
    d[j]=as.matrix(data[index[j],1:p]-X_bar)%*%invs%*%t(data[index[j],1:p]-X_bar)
    pt[j]=(j-.5)/ni
    chi2t[j]=qchisq(pt[j],p)
    H[j]=pchisq(d[j],p)
  }
  d=sort(d)
  #Q-Q plot
  fileName=paste('g',i,'Q-Qplot.png',sep = "")
  png(filename = fileName)
  plot(d,chi2t,xlab = "马氏距离", ylab = "chi2分位数")
  main_=paste('第',i,'组 Q-Q 图')
  title(main_)
  abline(a=0,b=1)
  dev.off()
  #P-P plot
  H=sort(H)
  fileName=paste('g',i,'P-Pplot.png',sep = "")
  png(filename = fileName)
  plot(pt,H,xlab = "P_t", ylab = "分布函数")
  main_=paste('第',i,'组 P-P 图')
  title(main_)
  abline(a=0,b=1)
  dev.off()
}

# end