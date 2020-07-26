# maniu data 
data.o=mushrooms
# 删去只有一个取值的列
data.o$veil.type=NULL
# 计算变量重要性
library(randomForest)
model=randomForest(class~.,data.na,na.action =na.omit , importance=T)
varImpPlot(model)
library(magrittr)
library(dplyr)    # alternatively, this also loads %>%
# make dataframe from importance() output
feat_imp_df <- importance(model) %>% 
  data.frame() %>% 
  mutate(feature = row.names(.)) 
feat_imp_df <- xgb.importance(xgb.model) %>% 
  data.frame() %>% 
  mutate(feature = row.names(.)) 
# plot dataframe
ggplot(feat_imp_df, aes(x = reorder(feature, MeanDecreaseGini), 
                        y = MeanDecreaseGini)) +
  geom_bar(stat='identity') +
  coord_flip() +
  theme_classic() +
  labs(
    x     = "Feature",
    y     = "Importance",
    title = "Feature Importance: <na.omit>"
  )




# 分训练集和测试集
set.seed(0)
test.index=sample(1:nrow(data.o),replace = F,size = ceiling(0.2*nrow(data.o)))

# 填补缺失值
# 多试一下看哪种方法好
data.na=data.o
na.index=which(data.na$stalk.root=='?')
data.na$stalk.root[na.index]=NA

# 要不要3-CV？？？？？？
#randomly shuffle the data
shuffledata = data[sample(nrow(data)), ]
#create 10 equally size folds
folds = cut(seq(1, nrow(shuffledata)), breaks = 3, labels = FALSE)
testIndexes = which(folds == i, arr.ind = TRUE)
testData = shuffledata[testIndexes,]
trainData = shuffledata[-testIndexes,]

# 抽取无缺失数据
data.imp=data.o[-na.index,-1]
data.imp$stalk.root=factor(data.imp$stalk.root)
set.seed(0)
imp.index=sample(1:nrow(data.imp),replace = F,size=ceiling(0.3*nrow(data.imp)))
original.stalk.root=factor(data.imp$stalk.root[imp.index])
data.imp$stalk.root[imp.index]=NA
# 使用VIM包的kNN
library(VIM)
kNN.model=kNN(data.imp,variable = 'stalk.root',k=3)
pred=kNN.model$stalk.root[imp.index]
acc=sum(pred==original.stalk.root)/length(pred)
acc
# MICE
library(mice)
mice.model=mice(data.imp)
mice.out=complete(mice.model)
pred=mice.out$stalk.root[imp.index]
acc=sum(pred==original.stalk.root)/length(pred)
acc
#rpart
library(rpart)
rpart.model=rpart(stalk.root~.,data=data.imp,method = "class",na.action = na.omit)
pred_=predict(rpart.model,data.imp[imp.index,])
pred=as.factor(colnames(pred_)[apply(pred_, 1, which.max)])
acc=sum(pred==original.stalk.root)/length(pred)
acc

# kNN imputation
# 注意训练集测试集分开补全
data.o$stalk.root[na.index] = NA
data.o$stalk.root = factor(data.o$stalk.root)
train.x = kNN(data.o[-test.index, -1], variable = 'stalk.root', k = 3)
train.x$stalk.root_imp = NULL
train.y = data.o[-test.index, 1]
train.data = train.x
train.data$class = train.y
test.x = kNN(data.o[test.index, -1], variable = 'stalk.root', k = 3)
test.x$stalk.root_imp = NULL
test.y = data.o[test.index, 1]
test.data = test.x
test.data$class = test.y

# 转换成哑变量
# library(fastDummies)
# train.xd = dummy_cols(train.x, remove_most_frequent_dummy = T)
# test.xd = dummy_cols(test.x, remove_most_frequent_dummy  = T)
library(dummies)
train.xd = dummy.data.frame(train.x, sep = ".")
train.xd = train.xd[, order(colnames(train.xd))]
train.yd = as.numeric(train.y) - 1
train.d = train.xd
train.d$class = train.yd

test.xd = dummy.data.frame(test.x, sep = ".")
test.xd$cap.surface.g = 0
test.xd = test.xd[, order(colnames(test.xd))]
test.yd = as.numeric(test.y) - 1
test.d = test.xd
test.d$class = test.yd

data.a=rbind(train.data,test.data)

library(GGally)
ggcorr(rbind(train.d,test.d),
       method = c("everything", "pearson"),nbreaks = 9,size=0)



data.o$stalk.root[data.o$stalk.root=='?']=NA
data.o$stalk.root=as.factor(data.o$stalk.root)
# Load library
library(ggplot2)
require(xgboost)
# load data
data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
# create model
bst <- xgboost(data = train$data, label = train$label, max.depth = 2,
               eta = 1, nthread = 2, nround = 2, objective = "binary:logistic")
# importance matrix
imp_matrix <- xgb.importance(colnames(agaricus.train$data), model = bst)
# plot 
xgb.ggplt<-xgb.ggplot.importance(importance_matrix = imp_matrix, top_n = 4)
# increase the font size for x and y axis
xgb.ggplt+theme( text = element_text(size = 20),
                 axis.text.x = element_text(size = 15, angle = 45, hjust = 1))


