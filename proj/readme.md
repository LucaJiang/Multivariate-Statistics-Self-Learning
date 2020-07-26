# 多元期末大作业

Kaggle 蘑菇数据集：辨别蘑菇是否可食用

数据集网址：[https://www.kaggle.com/uciml/mushroom-classification](https://www.kaggle.com/uciml/mushroom-classification)

最终作品在pdf文件中。

摘要：
本文基于 UCI 蘑菇数据集，建立判别蘑菇是否可食用的分类器。数据集样本量为 8124，其
中可食用和不可食用分别为 4208 和 3916，自变量有 22 个，均为因子型变量。首先对数据进
行详细的探索性分析。对于缺失值，尝试决策树、多重填补和 kNN 三种填补方法，最终选用
kNN 对训练集和测试集分别进行填补。之后，根据模型需求，将因子型变量编码为哑变量。
使用主成分回归、线性判别分析、LASSO 回归、逐步回归、决策树（CART、C4.5、C5.0）、
随机森林、XGBoost、kNN、SVM 、NN、RIPPER 和 PART，共 14 种模型建立了性能优秀的
分类器，并基于树模型给出了特征的重要性。

如果我有时间可能会把这玩意翻译成英文放kaggle上
