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

# Figuring out the type for these
typeof(e$values)
typeof(e$vectors)


# Question 2

# Create a list with the following named elements:

# my_matrix, which is a 4 x 4 matrix filled with random uniform values
my_matrix <- matrix(data=runif(16), nrow=4, ncol=4)
print(my_matrix)

# my_logical which is a 100-element vector of TRUE or FALSE values. Do this efficiently by setting up a vector of random values and then applying an inequality to it.
l <- runif(100)
my_logical <- l>0.5
print(my_logical)

# my_letters, which is a 26-element vector of all the lower-case letters in random order.
my_letters <- c(sample(letters, size = 26, replace=FALSE))
print(my_letters)

# create a new list, which has the element[2,2] from the matrix, the second element of the logical vector, and the second element of the letters vector.
new_list <- list(my_matrix[2,2],my_logical[2],my_letters[2])
print(new_list)

# use the typeof() function to confirm the underlying data types of each component in this list
typeof(new_list[[1]]) # double
typeof(new_list[[2]]) # logical
typeof(new_list[[3]]) # character

# combine the underlying elements from the new list into a single atomic vector with the c() function.
combo_vector <- c(new_list[[1]], new_list[[2]], new_list[[3]])

# what is the data type of this vector? Character 
typeof(combo_vector)

# Question 3
# Create a data frame with the two variables (= columns) and 26 cases (= rows) below:

# call the first variable my_unis and fill it with 26 random uniform values from 0 to 10
my_unis <- runif(26, min = 0, max = 10)

# call the second variable my_letters and fill it with 26 capital letters in random order.
my_letters <- c(sample(LETTERS,size=26, replace = FALSE))

dFrame <- data.frame(my_unis,my_letters, stringsAsFactors=FALSE)
print(dFrame)
# for the first variable, use a single line of code in R to select 4 random rows and replace the numerical values in those rows with NA.
dFrame[sample(length(my_unis), size = 4, replace = FALSE),1] <- NA
print(dFrame)

# for the first variable, write a single line of R code to identify which rows have the missing values.
which(!complete.cases(dFrame$my_unis))

# re-order the entire data frame to arrange the second variable in alphabetical order
dFrame <-dFrame[order(dFrame$my_letters),]
print(dFrame)

# calculate the column mean for the first variable.
mean(dFrame$my_unis, na.rm = TRUE)
