### Homework 9 Program Body
#### Rachel Hall 

source("HWFunction.R")

print(dataset <-gendata(nGroup, nName ,nSize = c(30,30), nMean=c(74,62), nSD)) 

print(model <- anovamodel(dataset)) 

plot <- boxplot(dataset)

fitLinear2()
myPars <-list(x=1:10,y=runif(10))
fitLinear2(myPars)

model <- anovamodel(dataset)
aov_table()