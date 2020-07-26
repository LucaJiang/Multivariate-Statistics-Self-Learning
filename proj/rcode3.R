# step----
glm.model.ori=glm(class~.,data = train.d,family = binomial())
glm.model=step(glm.model.ori,direction = "back")
glm.model2=step(glm.model,direction = "back")
summary(glm.model2)
glm.pred_=predict(glm.model2,test.xd)
glm.pred=sapply(glm.pred_, function(x){ if(x>=0)1 else 0})
glm.tab=table(glm.pred,test.yd)
glm.acc=sum(glm.pred==test.yd)/length(test.yd)

# PCR----
pca.model=prcomp(train.xd)
screeplot(pca.model,type = "l")
num.pc=20
pcr.model=glm(train.yd~.,data = as.data.frame(pca.model$x[,1:num.pc],train.yd),family = binomial())
summary(pcr.model)
pcr.coef=pcr.model$coefficients[-1]/pca.model$sdev[1:num.pc]
odd.ratio=exp(pcr.coef)
pcr.ori.coef=pcr.coef%*%t(pca.model$rotation[,1:num.pc])
pcr.pred_20=as.numeric(as.matrix(test.xd)%*%t(pcr.ori.coef))
plot(pcr.pred_20,col=test.y)
pcr.pred=sapply(pcr.pred_20, function(x){ if(x>=3)1 else 0})
pcr.acc=sum(pcr.pred==test.yd)/length(test.yd)
# ROC
library(pROC)
library(ggplot2)
# pcr.roc=roc(response=test.yd,predictor =  as.numeric(pcr.pred_),plot = T,auc = T)
n4=roc(test.yd,pcr.pred_4)
     n5=roc(test.yd,pcr.pred_5)
     n6=roc(test.yd,pcr.pred_6)
     n7=roc(test.yd,pcr.pred_7)
     roclist=list("n=4"=n4,"n=5"=n5,"n=6"=n6,"n=7"=n7)
ggroc(roclist, legacy.axes = TRUE)+
  annotate("text",x = .80, y = .4,label = paste("AUC of n=4 =", round(n4$auc,2))) +
  annotate("text",x = .80, y = .3,label=paste("AUC of n=5 =", round(n5$auc,2)))+
  annotate("text",x = .80, y = .2,label=paste("AUC of n=6 =", round(n6$auc,2)))+
  annotate("text",x = .80, y = .1,label=paste("AUC of n=7 =", round(n7$auc,2)))+
  geom_abline(alpha=0.3)+
  labs(subtitle = "ROC of different #PCs using PCR")

#LASSO----
# Loading the library
library(glmnet)
lambda_seq <- 10^seq(-2, -5, by = -.2)
cv.out=cv.glmnet(as.matrix(train.xd),train.yd,
                       alpha = 1, lambda = lambda_seq, 
                       nfolds = 5,family = binomial())

# identifying best lamda
best_lam <- cv.out$lambda.min
best_lam
# Rebuilding the model with best lamda value identified
lasso.model = glmnet(as.matrix(train.xd),train.yd, alpha = 1, lambda = best_lam,family = binomial())
lasso.pred_ =predict(lasso.model, newx = as.matrix(test.xd), s = best_lam)
lasso.pred=sapply(lasso.pred_, function(x){ if(x>=0)1 else 0})
lasso.tab=table(lasso.pred,test.yd)
lasso.acc=sum(lasso.pred==test.yd)/length(test.yd)
lasso.model #lasso 选择的变量

# LDA----
library(MASS)
lda.model=lda(class~.,data=train.d)
lda.pred_=predict(lda.model,newdata= test.xd)
lda.pred=as.numeric(lda.pred_$class)-1
lda.tab=table(lda.pred,test.yd)
lda.acc=sum(lda.pred==test.yd)/length(test.yd)

# CART----
library(rpart)
library(rpart.plot)
dt.model=rpart(class~.,train.data, control = rpart.control(cp=1e-3))
plotcp(dt.model)
rpart.plot(dt.model,type = 1,extra = 1)
dt.pred_=predict(dt.model,test.x)
dt.pred=as.factor(colnames(dt.pred_)[apply(dt.pred_, 1, which.max)])
dt.tab=table(dt.pred,test.yd)
dt.acc=sum(dt.pred==test.y)/length(test.y)

# C4.5----
library(RWeka)
library(partykit)
C45.model=J48(class~.,train.data)
plot(as.party(C45.model))
print(C45.model)
C45.pred=predict(C45.model,test.x)
C45.tab=table(C45.pred,test.yd)
C45.acc=sum(C45.pred==test.y)/length(test.y)

C45.model1=J48(class~.,data.o[-test.index,])
plot(as.party(C45.model1))
print(C45.model1)
C45.pred1=predict(C45.model1,test.x)
C45.tab1=table(C45.pred1,test.yd)
C45.acc1=sum(C45.pred1==data.o[test.index,1])/length(test.y)

#C5.0----
library(C50)
train.data_=train.data
train.data_$bruises=as.numeric(train.data_$bruises)
C50.model=C5.0(class~.,train.data_)
plot(C50.model)
plot(as.party(C50.model))
test.x_=test.x
test.x_$bruises=as.numeric(test.x_$bruises)
C50.pred=predict(C50.model,test.x_)
C50.tab=table(C50.pred,test.yd)
C50.acc=sum(C50.pred==test.y)/length(test.y)

summary(C50.model)
c50.imp=C5imp(C50.model)
c50.imp_=data.frame(name=c("odor","spore.print.color",
                           "cap.surface",
                           "stalk.color.below.ring","stalk.surface.above.ring"),
                    count=c(100,53.18,52.24,52.18,0.98))
ggplot(c50.imp_,aes(x=reorder(name,count) ,y=count)) +
  geom_bar(stat='identity') +
  coord_flip() +
  theme_classic() +
  labs(
    x     = "Feature",
    y     = "Importance",
    title = "Feature Importance: <C5.0>"
  )



data.o_=data.o
data.o_$bruises=as.numeric(data.o_$bruises)
C50.model1=C5.0(class~.,data.o_[-test.index,])
plot(as.party(C50.model1))
C50.pred1=predict(C50.model1,test.x_)
C50.tab1=table(C50.pred1,test.yd)
C50.acc1=sum(C50.pred1==data.o[test.index,1])/length(test.y)


# RF----
library(randomForest)
rf.model=randomForest(x = train.x,y=train.y,importance=T)
rf.model$confusion
rf.pred=predict(rf.model,newdata = test.x)
rf.tab=table(rf.pred,test.yd)
rf.acc=sum(rf.pred==test.y)/length(test.y)

# JPip----
library(RWeka)
jrip.model=JRip(class~.,data = train.data,)
jr.pred=predict(jrip.model,newdata = test.x)
jr.tab=table(jr.pred,test.yd)
jr.acc=sum(jr.pred==test.y)/length(test.y)

part.model=PART(class~.,data = train.data,)
part.pred=predict(part.model,newdata = test.x)
part.tab=table(part.pred,test.yd)
part.acc=sum(part.pred==test.y)/length(test.y)

# kNN----
library(class)
knn.pred=knn(train.xd,test.xd,train.yd,k=1)
knn.tab=table(knn.pred,test.yd)
knn.acc=sum(knn.pred==test.yd)/length(test.y)

# SVM----
library(e1071)
set.seed(0)
svm.model = svm(
  class ~ .,
  train.d)
svm.pred_ = predict(svm.model, train.xd)
svm.pred=sapply(svm.pred_, function(x){ if(x>=0.5)1 else 0})
svm.tab=table(svm.pred,train.yd)
svm.acc = sum(svm.pred == train.yd) / length(train.yd)

svm.pred_ = predict(svm.model, test.xd)
svm.pred=sapply(svm.pred_, function(x){ if(x>=0.5)1 else 0})
svm.tab=table(svm.pred,test.yd)
svm.acc = sum(svm.pred == test.yd) / length(test.yd)

# NN----
library(neuralnet)
nn.model=neuralnet(class~.,train.d,hidden=1)
plot(nn.model)
nn.pred_=compute(nn.model,test.xd)$net.result
nn.pred=sapply(nn.pred_, function(x){ if(x>=0.5)1 else 0})
nn.tab=table(nn.pred,test.yd)
nn.acc=sum(nn.pred==test.yd)/length(test.yd)
library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(nn.model)

# Xgboost----
library(xgboost)
params <- list(
  "objective"           = "binary:logistic",
  "eval_metric"         = "auc",
  "eta"                 = 0.012,
  "subsample"           = 0.8,
  "max_depth"           = 8,
  "colsample_bytree"    =0.9,
  "min_child_weight"    = 5
)
xgb.bst <- xgb.cv(data = as.matrix(train.xd),params = params,
                  label = as.numeric(train.y)-1,maximize = TRUE,
                  nfold = 5,
                 nthread = 2, 
               nround = 3)
xgb.model <- xgboost(data = as.matrix(train.xd),
                     label = as.numeric(train.y)-1, 
                     nthread = 2, params = params,nrounds = 3)
xgb.pred_=predict(xgb.model,newdata = as.matrix(test.xd))
xgb.pred=as.factor(sapply(xgb.pred_, function (x){if(x>0.5) 'p' else 'e' }))
xgb.acc=sum(xgb.pred==test.y)/length(test.y)

# importance matrix
imp_matrix <- xgb.importance(colnames(train.xd), model = xgb.model)
# plot 
xgb.ggplt<-xgb.ggplot.importance(importance_matrix = imp_matrix, top_n = 20)
# increase the font size for x and y axis
library(ggplot2)
xgb.ggplt+theme( text = element_text(size = 20),
                 axis.text.x = element_text(size = 15, angle = 45, hjust = 1))+
  geom_bar(stat='identity') +
  theme_classic() +
  labs(
    x     = "Feature",
    y     = "Importance",
    title = "Feature Importance: <XGBoost>"
  )+ theme(legend.position = "none")

# Clustering----
# 数据量太大很卡，所以只对部分数据做聚类
library(cluster)
clu.ind=sample(1:1625,size=100)
clu.model=agnes(test.x[clu.ind,],method = "ward")
plot(clu.model,label=test.y[clu.ind],
     main="Dendrogram of agnes (ward)",xlab="class")
rect.hclust(clu.model, k = 2, border = 2:3)


# 指标分类
library(RColorBrewer)
pca.f.model=prcomp(t(train.xd))
plot(pca.f.model$x[,1:2],type='p',cex=0.3,
     main = 'scatter plot of first factor vs second factor',
     xlab='f1',ylab='f2',xlim = c(-65,35))
text(pca.f.model$x,cex = 0.8,pos = 4,labels = colnames(train.xd),col=1:114)

plot(pca.f.model$x[,1:2],type='p',cex=0.3,
     main = 'scatter plot of first factor vs second factor',
     xlab='f1',ylab='f2',xlim = c(5,20),ylim = c(-4,0))
text(pca.f.model$x,cex = 0.8,pos = 4,labels = colnames(train.xd),col=1:114)
