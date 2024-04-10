# Homework 9
# 27 March 2024
# RKH

library(ggplot2)
library(truncnorm)
### Question 1

gendata <- function(nGroup, nName, nSize, nMean, nSD) {
  nGroup <- 2
  nName <- c("Ambient", "Drought")
  nSD <- c(44,30)
  resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2]))
  TGroup <-rep(nName,nSize)
  ANOdata<-data.frame(TGroup, resVar)
  return(ANOdata)
}

anovamodel <- function(data) {
  ANOmodel <- aov(data$resVar~data$TGroup,data=data)
  z <- summary(ANOmodel)
  return(z)
}

boxplot <- function(data) {
  ANOPlot <- ggplot(data,aes(x=TGroup,y=resVar,fill=TGroup)) +
  geom_boxplot()
  print(ANOPlot)
}


### Question 2

fitdata <- function(p=NULL) {
  if(is.null(p)) {
    p <- list(x=runif(20),y=runif(20))
  }
  modfit <- lm(p$x~p$y) # fit the model
  outputs <- c(slope=summary(modfit)$coefficients[2,1],
             pValue=summary(modfit)$coefficients[2,4])
  plot(x=p$x,y=p$y) # quick plot to check output
  return(outputs)
}


