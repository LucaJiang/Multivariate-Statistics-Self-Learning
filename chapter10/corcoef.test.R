##典型相关系数的显著性检验
corcoef.test<-function(r, n, p, q, alpha=0.05)
{
  m<-length(r); Q<-rep(0, m); lambda <- 1
  for (k in m:1)
  {
    lambda<-lambda*(1-r[k]^2);
    Q[k]<- -log(lambda)
  }
  s<-0; i<-m
  for (k in 1:m)
  {
    Q[k]<- (n-k+1-1/2*(p+q+3)+s)*Q[k]
    chi<-1-pchisq(Q[k], (p-k+1)*(q-k+1))
    if (chi>alpha)
    {
      i<-k-1; break
    }
    s<-s+1/r[k]^2
  }
  ret=list(i=i,pval=chi)
  return(ret)
}