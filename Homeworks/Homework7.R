# Homework 7 
# Creating fake data sets to explore hypothesis

knitr::opts_chunk$set(collapse = TRUE)
library(ggplot2)
library(MASS) 

# Reading Data
z<-read.csv("Li_Soil_Dataset.csv", sep=",", comment.char = '#')
str(z)
z<-na.omit(z)
z$myVar<-z$Plant.biomass..g.
summary(z)

p1 <- ggplot(data=z, aes(x=myVar, y=after_stat(density))) +
  geom_histogram(color="grey",fill="cadetblue3",linewidth=0.2) 
print(p1)

# 2.Specifying the sample size, means, and variances from data groups. 
# Two data groups, ambient and drought with 30 values each

ambient<-z[z$Moisture.treatment=="Ambient",]
drought<-z[z$Moisture.treatment=="Drought",]

a_biomass <- ambient$myVar
sd(a_biomass, na.rm = FALSE)
mean(a_biomass, trim = 0, na.rm = FALSE)

d_biomass <- drought$myVar
sd(d_biomass, na.rm = FALSE)
mean(d_biomass, trim = 0, na.rm = FALSE)

# N = 60 
# Ambient SD = 44 
# Ambient Mean = 74
# Drought SD = 30
# Drought Mean = 62

# 3. Write code to create a random data set that has these attributes. Organize these data into a data frame with the appropriate structure.
library(truncnorm)
nGroup = 2 # number of treatment groups
nName = c("Ambient", "Drought") # names of groups
nSize = c(30,30) # number of observations in each group
nMean =c(74,62) # mean of each group
nSD <- c(44,30) # standard deviation of each group
ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),
            rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2])) #using rtruncnorm to enter in the lower and upper bounds since SD is so high
TGroup <- rep(nName,nSize) 
ANOdata <- data.frame(ID, TGroup, resVar)
str(ANOdata)

# 4. Now write code to analyze the data then write code to generate a useful graph of the data.

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

# Plotting the data 
ANOPlot <- ggplot(data=ANOdata,aes(x=TGroup,y=resVar,fill=TGroup)) +
  geom_boxplot()
print(ANOPlot)


# 5. Try running your analysis multiple times to get a feeling for how variable the results are with the same parameters, but different sets of random numbers.

# First run: F value = 2.18012, p-value = 0.1452127
# Second run: F value = 1.327416, p-value = 0.2539924 
# Third run: F value = 1.848383, p-value = 0.1792339

# All of these runs produced p-values greater than the alpha level of 0.05, which means we would fail to reject the null hypothesis for this data. This would mean that it can be concluded there isn't sufficient evidence to say there is a statistically significant difference between the means of the two groups. 

# 6. Now begin adjusting the means of the different groups.

# Adjusting the mean for ambient to 79 rather than 74 (+5). 
nGroup = 2 # number of treatment groups
nName = c("Ambient", "Drought") # names of groups
nSize = c(30,30) # number of observations in each group
nMean =c(79,62) # mean of each group
nSD <- c(44,30) # standard deviation of each group
ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),
            rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2])) #using rtruncnorm to enter in the lower and upper bounds since SD is so high
TGroup <- rep(nName,nSize) 
ANOdata <- data.frame(ID, TGroup, resVar)
str(ANOdata)
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))

# Results ranged in whether the p-value was greater or less than 0.05. 


# Adjusting the mean for drought to 57 rather than 62 (-5). 
nGroup = 2 # number of treatment groups
nName = c("Ambient", "Drought") # names of groups
nSize = c(30,30) # number of observations in each group
nMean =c(74,57) # mean of each group
nSD <- c(44,30) # standard deviation of each group
ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),
            rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2])) #using rtruncnorm to enter in the lower and upper bounds since SD is so high
TGroup <- rep(nName,nSize) 
ANOdata <- data.frame(ID, TGroup, resVar)
str(ANOdata)
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))
# Results ranged in whether the p-value was greater or less than 0.05. 

# Adjusting the mean for drought to 47 (-15 difference from original) 
nGroup = 2 # number of treatment groups
nName = c("Ambient", "Drought") # names of groups
nSize = c(30,30) # number of observations in each group
nMean =c(74,47) # mean of each group
nSD <- c(44,30) # standard deviation of each group
ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),
            rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2])) #using rtruncnorm to enter in the lower and upper bounds since SD is so high
TGroup <- rep(nName,nSize) 
ANOdata <- data.frame(ID, TGroup, resVar)
str(ANOdata)
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))

# Changing the mean for drought by this much produced a significant pattern for p-values less than 0.05 and therefore, sufficient evidence is there to say there is a statistically significant difference between the means of the two groups.


# 7. Alternatively, for the effect sizes you originally hypothesized, what is the minimum sample size you would need in order to detect a statistically significant effect? 

# Returning to the original mean values of 74 and 62, but changing the sample size of observations in each group

nGroup = 2 # number of treatment groups
nName = c("Ambient", "Drought") # names of groups
nSize = c(55,55) # number of observations in each group
nMean =c(74,62) # mean of each group
nSD <- c(44,30) # standard deviation of each group
ID <- 1:(sum(nSize)) # id vector for each row
resVar <- c(rtruncnorm(n=nSize[1], a=0, b=Inf, mean=nMean[1],sd=nSD[1]),
            rtruncnorm(n=nSize[2], a=0, b=Inf, mean=nMean[2],sd=nSD[2])) #using rtruncnorm to enter in the lower and upper bounds since SD is so high
TGroup <- rep(nName,nSize) 
ANOdata <- data.frame(ID, TGroup, resVar)
str(ANOdata)
ANOmodel <- aov(resVar~TGroup,data=ANOdata)
print(ANOmodel)
print(summary(ANOmodel))

# When attempting to change the sample size, sample size of 50 observations for each group resulted in 2 out of 3 times with a p-value lower than 0.05. To increase the chances of having a low enough p-value to reject the null hypothesis, I adjusted the sample size to 55 observations per group which gave consistent p-values lower than 0.05. 