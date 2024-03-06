# Experimental Designs
# 29 Feb 2024 
# RKH

library(tidyverse)

# Data Frame construction for Regression Data
n = 50  # number of observations (rows)

varA <- runif(n) # random uniform values (independent)
varB <- runif(n) # a second random column (dependent)
varC <- 5.5 + varA*10 # a noisy linear relationship with varA
ID <- seq_len(n) # creates a sequence from 1:n (if n > 0!)
regData <- data.frame(ID,varA,varB,varC)
head(regData)
str(regData)

# Basic Regression analysis in R
# model
regModel <- lm(varB~varA,data=regData)

# model output
regModel # printed output is sparse
str(regModel) # complicated, but has "coefficients"
head(regModel$residuals) # contains residuals

# 'summary' of model has elements
summary(regModel) # 
summary(regModel)$coefficients
str(summary(regModel))

# best to examine entire matrix of coefficients:
summary(regModel)$coefficients[] #shows all

# can pull results from this, but a little wordy
summary(regModel)$coefficients[1,4]   #p value for intercept
summary(regModel)$coefficients["(Intercept)","Pr(>|t|)"] # uggh


# alternatively unfurl this into a 1D atomic vector with names
z <- unlist(summary(regModel))
str(z)
z
z$coefficients7

# grab what we need and put into a tidy  list

regSum <- list(intercept=z$coefficients1,
               slope=z$coefficients2,
               interceptP=z$coefficients7,
               slopeP=z$coefficients8,
               r2=z$r.squared)

# much easier to query and use
print(regSum)
regSum$r2
regSum[[5]]

# Basic ggplot of regression model
regPlot <- ggplot(data=regData,aes(x=varA,y=varB)) +
  geom_point() +
  stat_smooth(method=lm,se=0.99) # default se=0.95 
print(regPlot)
# ggsave(filename="Plot1.pdf",plot=regPlot,device="pdf")

# Data frame construction for one-way ANOVA
nGroup <- 3 # number of treatment groups
nName <- c("Control","Treat1", "Treat2") # names of groups
nSize <- c(12,17,9) # number of observations in each group
nMean <- c(40,41,60) # mean of each group
nSD <- c(5,5,5) # standardd deviation of each group

ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rnorm(n=nSize[1],mean=nMean[1],sd=nSD[1]),
            rnorm(n=nSize[2],mean=nMean[2],sd=nSD[2]),
            rnorm(n=nSize[3],mean=nMean[3],sd=nSD[3]))
TGroup <- rep(nName,nSize)
ANOdata <- data.frame(ID,TGroup,resVar)
str(ANOdata)

# Basic ANOVA in R
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
z <- summary(ANOmodel)
str(z)
aggregate(resVar~TGroup,data=ANOdata,FUN=mean)
unlist(z)
unlist(z)[7]
ANOsum <- list(Fval=unlist(z)[7],probF=unlist(z)[9])
ANOsum

# Basic ggplot of ANOVA data
ANOPlot <- ggplot(data=ANOdata,aes(x=TGroup,y=resVar,fill=TGroup)) +
  geom_boxplot()
print(ANOPlot)
# ggsave(filename="Plot2.pdf",plot=ANOPlot,device="pdf")

# Data frame construction for logistic regression
xVar <- sort(rgamma(n=200,shape=5,scale=5))
yVar <- sample(rep(c(1,0),each=100),prob=seq_len(200))
lRegData <- data.frame(xVar,yVar)

# Logistic regression analysis in R
lRegModel <- glm(yVar ~ xVar,
                 data=lRegData,
                 family=binomial(link=logit))
summary(lRegModel)
summary(lRegModel)$coefficients
