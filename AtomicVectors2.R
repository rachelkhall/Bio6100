# Atomic Vectors II
# 06 February 2024
# Rachel Hall 
library(ggplot2)
# create an empty vector, specify mode and length (avoid)
z <- vector(mode="numeric", length=0)
print(z)

z <- c(z,5)
print(z)
# This "dynamic sizing" is very slow

# has 100 0s in a numeric vector
z<- rep(0,100)
length(z)
head(z)
tail(z)
z[c(50,51,52)]

#preferred way to build a vector is with NAs (better to start)
z <- rep(NA,100)
head(z)

# but what is its type
typeof(z)

# take advantage of coercion!
z[1] <- "Washington"
head(z)
typeof(z)

# Efficiently creating a vector with many names

my_vector <- runif(100)
# my_names <- paste("Species",seq(1:length(my_vector)),sep="") #original 
my_names <- paste("Genus",seq(1:length(my_vector)),
                  "species",
                  sep="_")
head(my_names)
names(my_vector) <- my_names
head(my_vector)
str(my_vector)

# Using rep to repeat elements and create vectors
# rep for repeating elements 
rep(0.5,6) # give the element (or vecotr!) and number of times to repeat
rep(x=0.5,times=6) # using the argument names is always prudent 
rep(times =6, x=0.05) # with argument names, order is not important 
my_vec <- c(1,2,3)
rep(x=my_vec, times=2) # applies to entire vectors 
rep(x=my_vec,each=2) # repeat each element individually
rep(x=my_vec,times=my_vec) # what does this do?
rep(x=my_vec,each=my_vec) # and this?
rep(x=my_vec,each=c(3,2,1)) # and this?

#  Using seq to create regular sequences
seq(from=2, to=4) # set limits for integer sequences
-2:2 # very common short cut with no explicit function wrappers
seq(from=2,to=4,by=0.5) # use a by function can generate real numbers
x <- seq(from=2, to=4,length=7) # sometimes easier to just specify the length
print(x)
my_vec <- 1:length(x) # commonly used, but actually slow
print(my_vec)
seq_along(my_vec) # much faster for models and big data!
seq_len(5) # this is also faster than 1:5

set.seed(2400)

# Using rnorm and runif to create vectors of random numbers
runif(5) # 5 random uniform values betweeon 0 and 1
runif(n=3,min=100, max=101) # 3 random uniform values between 100 and 101

rnorm(6) # 6 random normal values with mean 0 and standard deviation 1
rnorm(n=5, mean=100, sd=30) # 5 random normal values with mean 100 and sd 30

# Explore distributions by sampling and plotting
library(ggplot2) # do this at the very start
z<- runif(100000) # default uniform (0,1)
qplot(x=z)
z <- rnorm(100000) #default normal (0,1)
qplot(x=z)

long_vec <-seq_len(10)
typeof(long_vec)
str(long_vec)

sample(x=long_vec) # with no other params, this reorders the vector
sample(x=long_vec, size=3) # specify a number (sampling without replacement)
