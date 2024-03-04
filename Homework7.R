# Homework 7 
# Creating fake data sets to explore hypothesis

library(ggplot2)
library(MASS) 

# Reading Data
z<-read.csv("Li_Soil_Dataset.csv", sep=",", comment.char = '#')
str(z)
z<-na.omit(z)
z$myVar<-z$Plant.biomass..g.
summary(z)

p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey",fill="cadetblue3",size=0.2) 
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

