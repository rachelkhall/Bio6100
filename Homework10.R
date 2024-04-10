# Homework 10
# 3 April 2024
# RKH

### Question 1 

# Using a for loop, write a function to calculate the number of zeroes in a numeric vector. Before entering the loop, set up a counter variable counter <- 0. Inside the loop, add 1 to counter each time you have a zero in the vector. Finally, use return(counter) for the output.

number_zs <- function(z = round(runif(100), digits=0)) {
  
  counter <- 0
  for (i in seq_along(z)) {
    if (z[i]==0) counter <- counter+1
  }
  
  return(counter)
  
}

number_zs()


### Question 2 

# Use subsetting instead of a loop to rewrite the function as a single line of code.

number_zs2 <- function(z= round(runif(100), digits = 0)) {
  print(counter <-sum(z==0))
}

number_zs2()

### Question 3

# Write a function that takes as input two integers representing the number of rows and columns in a matrix. The output is a matrix of these dimensions in which each element is the product of the row number x the column number.

product_matrix <- function(r, c) {
  
  m <- matrix(NA, nrow = r, ncol = c)
  for (i in 1:nrow(m)) {
    for (j in 1:ncol(m)) {
      m[i,j] <- i*j
    }
  }
  print(m)
}

product_matrix(r=3, c=5)

### Question 4 

# 4a. Simulate a dataset with 3 groups of data, each group drawn from a distribution with a different mean. The final data frame should have 1 column for group and 1 column for the response variable.

library(ggplot2)

x <- c(rep("Control",5),rep("Treatment",5))
y <- runif(10, min = 1, max = 50)
df <- data.frame(group=seq_along(x),x,y)
print(df)

# 4b. Write a custom function that 1) reshuffles the response variable, and 2) calculates the mean of each group in the reshuffled data. Store the means in a vector of length 3.

shuffle_data <- function(z=NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 3*rnorm(20)
    z <- data.frame(x_obs,y_obs)} # set up data frame                 
  z[,2] <- sample(z[,2]) # use sample function with defaults to reshuffle column
  
  return(z)
}

# 4c. Use a for loop to repeat the function in b 100 times. Store the results in a data frame that has 1 column indicating the replicate number and 1 column for each new group mean, for a total of 4 columns.





# 4d. Use qplot() to create a histogram of the means for each reshuffled group. Or, if you want a challenge, use ggplot() to overlay all 3 histograms in the same figure. How do the distributions of reshuffled means compare to the original means?