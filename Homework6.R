# Homework 6 
# 21 Feb 2024
# Rachel Hall 


library(ggplot2) #for graphics 
library(MASS)
library(dplyr) 

# Used Li_Soil_Dataset from examples
#z <- rnorm(n=3000,mean=0.2)
#z <- data.frame(1:3000,z)
#names(z) <- list("ID","myVar")
#z <- z[z$myVar>0,]
#str(z)
#summary(z$myVar)

# Reading Data
z<-read.csv("Li_Soil_Dataset.csv", sep=",", comment.char = '#')
str(z)
z<-na.omit(z)
z$myVar<-z$Plant.biomass..g.
summary(z)

# Plotting Histogram
p1 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="grey",fill="cadetblue3",size=0.2) 
print(p1)

# Adding Empirical Density Curve
p1 <-  p1 +  geom_density(linetype="dotted",size=0.75)
print(p1)

#Getting maximum likelihood parameters for normal
normPars <- fitdistr(z$myVar,"normal")
print(normPars)
str(normPars)
normPars$estimate["mean"] # note structure of getting a named attribute

# Plot Normal Probability
meanML <- normPars$estimate["mean"]
sdML <- normPars$estimate["sd"]

xval <- seq(0,max(z$myVar),len=length(z$myVar))

stat <- stat_function(aes(x = xval, y = ..y..), fun = dnorm, colour="mediumorchid", n = length(z$myVar), args = list(mean = meanML, sd = sdML))
p1 + stat

# Plot exponential probability density
expoPars <- fitdistr(z$myVar,"exponential")
rateML <- expoPars$estimate["rate"]

stat2 <- stat_function(aes(x = xval, y = ..y..), fun = dexp, colour="green", n = length(z$myVar), args = list(rate=rateML))
p1 + stat + stat2

# Plot uniform probability density
stat3 <- stat_function(aes(x = xval, y = ..y..), fun = dunif, colour="darkgreen", n = length(z$myVar), args = list(min=min(z$myVar), max=max(z$myVar)))
p1 + stat + stat2 + stat3

# Plot gamma probability
gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat4 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="navy", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p1 + stat + stat2 + stat3 + stat4

#Plot beta probability
pSpecial <- ggplot(data=z, aes(x=myVar/(max(myVar + 0.1)), y=..density..)) +
  geom_histogram(color="grey60",fill="plum1",size=0.2) + 
  xlim(c(0,1)) +
  geom_density(size=0.75,linetype="dotted")

betaPars <- fitdistr(x=z$myVar/max(z$myVar + 0.1),start=list(shape1=1,shape2=2),"beta")
shape1ML <- betaPars$estimate["shape1"]
shape2ML <- betaPars$estimate["shape2"]

statSpecial <- stat_function(aes(x = xval, y = ..y..), fun = dbeta, colour="orchid4", n = length(z$myVar), args = list(shape1=shape1ML,shape2=shape2ML))
pSpecial + statSpecial

#Comparing Likelihood (higher number = best fit)
normPars$loglik 
gammaPars$loglik 
expoPars$loglik

# Gamma distribution would be the best fit as it has the highest number for likelihood

#Simulating Data
z <- rgamma(n= 60, shape=shapeML, rate=rateML) 
z <- data.frame(1:60,z)

names(z) <- list("ID","myVar")
z <- z[z$myVar>0,]
str(z)
z <- na.omit(z)

p2 <- ggplot(data=z, aes(x=myVar, y=..density..)) +
  geom_histogram(color="snow",fill="darkseagreen",size=0.2) 
print(p2)

normPars <- fitdistr(z$myVar,"normal")
print(normPars)

str(normPars)

gammaPars <- fitdistr(z$myVar,"gamma")
shapeML <- gammaPars$estimate["shape"]
rateML <- gammaPars$estimate["rate"]

stat5 <- stat_function(aes(x = xval, y = ..y..), fun = dgamma, colour="darkslategrey", n = length(z$myVar), args = list(shape=shapeML, rate=rateML))
p2 + stat5

p1 + stat4

# Comparing the simulated plot to the data we imported 
# While the simulated data does not exactly match the original data set, it does show similar trends in the values. Both the simulated data and the original data are right skewed as well, which illustrates this similarity. 
