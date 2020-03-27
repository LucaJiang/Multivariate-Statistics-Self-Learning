#第七章 主成分分析 p277 p282 p285
#例7.2.1 中学生身体四项指标的主成分分析
#例7.3.1 16项身体指标数据分析
#主成分分析 指标分类 主成分回归

#导入数据----
library(readr)
data <- read_csv("table7.4.csv")
#导入包----
library(psych)

#碎石图检验----
fa.parallel(data,fa="pc")
abline(1,0)
#一个或两个主成分

#提取主成分----
pc=principal(r = data,nfactors = 2,rotate = 'none',scores = T)
#如果不选rotate = 'none'做出来的是因子分析
pc
plot(pc$scores,type='p',cex=0,main = '第一主成分对第二主成分得分图',
     xlab='Z1',ylab='Z2')
text(pc$scores,cex = 0.6)
#end1


#指标分类----
#导入数据----
data <- read_csv("table7.5.csv", col_names = FALSE)

#提取主成分----
pc=principal(r = data,nfactors = 2,rotate = 'none',scores = T)
pc
plot(pc$loadings,type='p',cex=0.5,
     main = '第一负荷向量对第二负荷向量散布图',
     xlab='f1',ylab='f2')
text(pc$loadings,cex = 0.8,pos = 4)
abline(h=0,lty=2)
#end2


#主成分回归----
data=read_table2("table7.6.txt")
data_sc=scale(data)
data_x=data_sc[,-4]
eig=eigen(cov(data_x))#取前两个主成分
eig$vectors[,2]=-eig$vectors[,2]#为了和书上一致
pc=principal(data_x,nfactors = 2,rotate = 'none',scores = T)
fit=lm(data_sc[,4]~data_x%*%eig$vectors[,-3])
x_coef=eig$vectors[,-3]%*%fit$coefficients[c(2,3)]
ori_x_coef=x_coef/SD(data)[-4]*SD(data)[4]
ori_int=mean(data$y)-
        sum(x_coef/SD(data)[-4]*colMeans(data[,-4]))*SD(data)[4]
summary(fit)
fit_ori=lm(y~.,data)
summary(fit_ori)
#pca的回归和普通回归相比, 系数更显著
#end3