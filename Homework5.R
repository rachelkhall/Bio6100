# Homework 5 
# Rachel Hall 
# Feb 14, 2024
library(ggplot2)


# Question 1
n_dims <- sample(3:10,1)
print(n_dims)

# Creating a vector of consecutive integers from 1 to n_dims^2
n_dimssquared <- n_dims^2
vector <- 1: n_dimssquared

# Using sample function to randomly reshuffle these 
shuffled_vec <- sample(vector)

# Creating a square matrix 
sq_m <- matrix(data = shuffled_vec, nrow = n_dims, ncol = n_dims)
print(sq_m)

# Transpose matrix, rows and columns flip
t <- t(sq_m)
print(t)

# Calculate the sum and mean of elements in the first row and then the last row

sumfirst <- sum(t[1,])
print(sumfirst)

meanfirst <- mean(t[1,])
print(meanfirst)

sumlast <- sum(t[n_dims,])
print(sumlast)

meanlast <- mean(t[n_dims,])
print(meanlast)

# Using eigen() function and use it on matrix
e <- eigen(t)
print(e)

# 
typeof(e$values)
typeof(e$vectors)
