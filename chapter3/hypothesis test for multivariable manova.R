#P83-85 �������ֵ�����ļ��� ��3.3.2
#ϰ���� 3-13
# import data ----
table3_3 <- read_delim("table3.3.txt", "\t", escape_double = FALSE, trim_ws = TRUE)
data=table3_3

#����һ: ������(g=1,2,3)������ָ��֮�������������� ----
##n_1=n_2=n_3=20, n=60, p=4, k=3
##H_0: \miu^(1)=\miu^(2)=\miu^(3) vs H_1: \miu^(1) \miu^(2) \miu^(3)������һ�Բ����
##��Ȼ��ͳ����\Lambda~\Lambda(p,n-k,k-1)
##F~F(2p,2(n-p+1))
n=60; p=4; k=3;
x_bar=as.matrix(aggregate(data[,1:4],by=data[,5],FUN=mean))[,2:5]#group mean
X_bar=colMeans(x_bar)#total mean
A=matrix(0,p,p);T_=A #����T�൱��TRUE, ���Լ�_
B=A;
for (i in 1:k) {
  index=which(data[,p+1]==i)
  # ���������
  A=A+t(as.matrix(data[index,1:p]))%*%as.matrix(data[index,1:p])-
    length(index)*x_bar[i,]%*%t(x_bar[i,])
  
  # ��������
  B=B+(x_bar[i,]-X_bar)%*%t(x_bar[i,]-X_bar)*length(index)
  
  # �������
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


#�����: ������ָ��֮��Ĳ���������ļ���ָ������ ----
pval_each=vector(length = p)
for (i in 1:p) {
  f=(T_[i,i]-A[i,i])/(k-1)/A[i,i]*(n-k)
  pval_each[i]=pf(f,k-1,n-k,lower.tail = F)
}
pval_each #pval for each variable

##��Ԫ�������
y=as.matrix(data[,1:4])
fit=manova(y~as.factor(as.matrix(data[,5])))#��Ҫת��Ϊ���ӱ���������������
summary(fit)
summary.aov(fit)
# ע��manovaʹ��Pillai-Bartlett Trace (also known as Pillai��s trace)
# ������������˹LAMBDAͳ����, ���Խ����������ͬ!
# ref: https://gaopinghuang0.github.io/2017/11/20/MANOVA-notes-and-R-code

# ������: ��ÿ�����������Ƿ���һԪ��̬ ----
##qqnorm
for (i in 1:k) {
  x=as.matrix(data[,i])
  y=(x-mean(x))/sd(x)
  qqnorm(y,main =paste('X',i,'Q-Q Plot'))
  qqline(y)
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

#������: ����\chi-squreͼ���鷨���������ݷֱ�����Ƿ�������Ԫ��̬�ֲ�
for (i in 1:k) {
  index=which(data[,p+1]==i)
  ni=length(index)#��i������n_i
  s=cov(data[index,1:p])
  invs=solve(s)
  d=vector(length = ni)#���Ͼ���
  chi2t=d#��λ��
  pt=d;#����
  H=d;#value of cdf
  for (j in 1:ni) { #�������Ͼ���ͷ�λ��
    d[j]=as.matrix(data[index[j],1:p]-X_bar)%*%invs%*%t(data[index[j],1:p]-X_bar)
    pt[j]=(j-.5)/ni
    chi2t[j]=qchisq(pt[j],p)
    H[j]=pchisq(d[j],p)
  }
  d=sort(d)
  #Q-Q plot
  plot(d,chi2t,xlab = "���Ͼ���", ylab = "chi2��λ��")
  main_=paste('��',i,'�� Q-Q ͼ')
  title(main_)
  abline(a=0,b=1)
  #P-P plot
  H=sort(H)
  plot(pt,H,xlab = "P_t", ylab = "�ֲ�����")
  main_=paste('��',i,'�� P-P ͼ')
  title(main_)
  abline(a=0,b=1)
}

# end