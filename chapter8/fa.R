#第八章 因子分析 p305
#例8.3.1 盐泉水化学分析资料的因子分析
#因子分析 Q型因子分析

#导入数据----
library(readr)
data=read_table2("table8.1.txt")
n=20;p=7
#导入包----
library(psych)

#碎石检验----
fa.parallel(data,fa ="both")
abline(h=0,lty=5)
#RiA说对于efa, 准则的特征值数是大于0,
#这个函数的答案似乎错了?它建议取1个factor
#我判断是3个

#注意:
#这里虽然用的是pca, 但是答案和书上一样
#我看了书上的推到, 发现这本书因子分析确实和主成分差不多...
#在这段函数之后, 有用fa的尝试,但是得不到书上的答案
#例8.3.1 盐泉水化学分析资料的因子分析----
pc=principal(data,nfactors = 3,rotate = 'none')
pc$loadings
pc$communality
#例8.4.1 盐泉水化学分析资料的因子分析----
pc_r=principal(data,nfactors = 3,rotate = 'varimax',scores = T)
pc_r$loadings
#plot
factor.plot(pc,labels =c(1:7),show.points = F)
fa.diagram(pc_r)
#例8.5.1----
plo=pc_r$scores
plo[,1]=-plo[,1]
plot(plo,cex=0.5,pch=8,main = '第一二因子得分散布图',
     xlab = 'factor1',ylab ='factor2',xlim=c(-2,2),ylim = c(-1,4))
text(plo,cex = 0.6,pos=4)
abline(h=0,v=0)

#Q型因子分析----
#例8.6.1----
#计算Q矩阵
Q=matrix(NA,n,n)
for (i in 1:n) {
  for (j in 1:n) {
    Q[i,j]=
      sum(data[i,]*data[j,])/sqrt(sum(data[i,]^2)*sum(data[j,]^2))
  }
}
pc_q=principal(Q,nfactors = 3,rotate = 'none')
pc_q
pc_q_r=principal(Q,nfactors = 3,rotate = 'varimax')
pc_q_r


#fa----
#提取公共因子
fa=fa(data,nfactors=3,rotate='none',fm='minres',score=T)
fa
fa$loadings
fa$communality
#算不出和书上一样的答案orz
#因子旋转
fa=fa(data,nfactors=3)#,rotate='promax',fm='pa',score=T)
fa
fa$loadings
fa$communality
fa.diagram(fa)
factor.plot(fa)
#end