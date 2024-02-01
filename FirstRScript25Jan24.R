# First comment to explain what this program is doing.
# Be expansive and describe it in great detail. This may seem trivial, but will become increasginly important as you create complex programs.
# 25 January 2024


#Preliminaries
library(ggplot2)
set.seed(100)
library(TeachingDemos) # use this to set random number seed from a character strings
char2seed("green tea")
char2seed("green tea",set=FALSE)

# control shift C will create a comment

#

# Global variables
nRep <- 10000


# Create or read in data
ranVar1 <- rnorm(nRep)
# print(ranVar1)
head(ranVar1)

tail(ranVar1)

ranVar2 <- rnorm(nRep)

qplot(x=ranVar1)

ranProd <- ranVar1*ranVar2

length(ranProd)

str(ranProd)

head(ranProd)