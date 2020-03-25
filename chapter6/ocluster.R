ocluster = function(datasam, classnum) {
  #有序样本聚类，输入datasam为样本数据阵，每一行为一个样本；
  #输入classnum为要分的类数
  #返回值result1为分类结果示意图
  #各类的起始点存在变量breaks中
  #输出三个矩阵 ra_dis:距离矩阵 leastlost:最小损失矩阵 classid:分类标识矩阵
  
  #author:banmudi 2010.11
  
  
  
  #样本数
  sam_n = dim(datasam)[1]
  
  #子函数，计算i-j个样本组成的类的半径
  radi = function(i, j) {
    #提取i-j个样本
    temp =as.matrix( datasam[i:j, ])
    mu = colMeans(matrix(temp,j-i+1))
    vec = apply(matrix(temp,j-i+1), 1, function(x) {
      x - mu
    })
    round(sum(apply(matrix(vec,j-i+1), 2, crossprod)),3)   
    
  }
  
  
  #计算距离矩阵
  ra_dis = matrix(0, sam_n, sam_n)
  rownames(ra_dis) = 1:sam_n
  colnames(ra_dis) = 1:sam_n
  for (i in 1:(sam_n - 1)) {
    for (j in (i + 1):sam_n) {
      ra_dis[i, j] = radi(i, j)
      ra_dis[j, i] = radi(i, j)
    }
  }
  
  #最小损失矩阵，行为样本数，列为分类数
  #leastlost[i,j]表示把1:i样本分成j类对应的最小损失
  leastlost = matrix(, sam_n - 1, sam_n - 1)
  rownames(leastlost) = 2:sam_n
  colnames(leastlost) = 2:sam_n
  diag(leastlost) = 0
  #round(leastlost,3);
  
  #记录下对应的分类结点
  classid = matrix(, sam_n - 1, sam_n - 1)
  rownames(classid) = 2:sam_n
  colnames(classid) = 2:sam_n
  diag(classid) = 2:sam_n
  
  
  #分成两类时，填写最小损失阵的第一列
  leastlost[as.character(3:sam_n), "2"] = sapply(3:sam_n,
                                                 function(xn) {
                                                   min(ra_dis[1, 1:(xn - 1)] + ra_dis[2:xn, xn])
                                                 })
  classid[as.character(3:sam_n), "2"] = sapply(3:sam_n, function(xn) {
    which((ra_dis[1, 1:(xn - 1)] + ra_dis[2:xn, xn]) == (min(ra_dis[1,
                                                                    1:(xn - 1)] + ra_dis[2:xn, xn])))[1] + 1
  })
  #分成j类时，填写最小损失阵的 第二列到最后一列
  for (j in as.character(3:(sam_n - 1))) {
    #分成j类
    leastlost[as.character((as.integer(j) + 1):sam_n), j] = sapply((as.integer(j) +
                                                                      1):sam_n, function(xn) {
                                                                        min(leastlost[as.character(j:xn - 1), as.character(as.integer(j) -
                                                                                                                             1)] + ra_dis[j:xn, xn])
                                                                      })
    
    classid[as.character((as.integer(j) + 1):sam_n), j] = sapply((as.integer(j) +
                                                                    1):sam_n, function(xn) {
                                                                      a = which((leastlost[as.character(j:xn - 1), as.character(as.integer(j) -
                                                                                                                                  1)] + ra_dis[j:xn, xn]) == min(leastlost[as.character(j:xn -
                                                                                                                                                                                          1), as.character(as.integer(j) - 1)] + ra_dis[j:xn,
                                                                                                                                                                                                                                        xn]))[1] + as.integer(j) - 1
                                                                    })
  }
  
  diag(classid) = 2:sam_n
  
  breaks = rep(0, 1, classnum)
  breaks[1] = 1
  breaks[classnum] = classid[as.character(sam_n), as.character(classnum)]
  flag = classnum - 1
  while (flag >= 2) {
    breaks[flag] = classid[as.character(breaks[flag + 1] -
                                          1), as.character(flag)]
    flag = flag - 1
  }
  
  print("distance matrix:");#cat("\n")
  print(ra_dis[2:sam_n,1:(sam_n-1)], na.print = ""); #输出距离矩阵
  print("leastlost matrix:")
  print(leastlost[2:(sam_n-1),1:(sam_n-2)], na.print = ""); #输出最小损失矩阵
  print("classid matrix:")
  print(classid[2:(sam_n-1),1:(sam_n-2)], na.print = ""); #输出分类标识矩阵
  cat("\n")
  print("result")
  #画一个简单的分类示意图
  result1=NULL
  for (p in 1:sam_n) {
    result1 <- cat(result1,p, " ")
    for (w in 1:length(breaks)) {
      if (p == breaks[w] - 1) {
        result1 <- cat(result1, "||")
      }
    }
    if (p == sam_n)
      result1= cat(result1, "\n")
  }
  return(leastlost)
}
