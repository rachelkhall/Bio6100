# Randomization Tests 
# RKH
# 2 April 2024

## General Steps in a Randomization Test
# 1. Define a metric $X$ as a single number to represent pattern
# 2. Calculate $X_{obs}$, the metric for the empirical (= observed) data
# 3. Randomize or reshuffle the data in a way that would uncouple association between the observed data and their assignment to treatments. Otherwise, the randomized data set should have the same dimensions and properties as the original data set.
# 4. For this single randomization, calculate $X_{sim}$, the metric for the simulated (= randomized) data.
# 5. Repeat steps (3) and (4) 1000 (or more times) to get a distribution for $X_{sim}$
# 6. Estimate the tail probability of the observed metric, given the null distribution $(p(X_{obs}|H_0))$.

#### Preliminaries

library(ggplot2)
set.seed(1000)


#### Simple toy example

# create treatment groups
trt_group <- c(rep("Control",4),rep("Treatment",5))
print(trt_group)

# create response variable
z <- c(runif(4) + 1, runif(5) + 10)
print(z)

# combine into data frame
df <- data.frame(trt=trt_group,res=z)
print(df)

# look at means in observed data
obs <- tapply(df$res,df$trt,mean)
print(obs)

# create a simulated data set

# set up a new data frame
df_sim <- df

# randomize assignment of response to treatment groups
df_sim$res <- sample(df_sim$res)
print(df_sim)

#look at means in simulated data
sim <- tapply(df_sim$res,df$trt,mean)
print(sim)


#### Read in data


####### ###########################################
# function: read_data
# read in (or generate) data set for analysis
# input: file name (or nothing, for this demo)
# output: 3 column data frame of observed data (x,y)
#------------------------------------------------- 
read_data <- function(z=NULL) {
  
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 10*rnorm(20)
    df <- data.frame(x_obs,
                     y_obs)} else { 
                       # set up data frame                 
                       df <-read.table(file=z,
                                       header=TRUE,
                                       sep=",")}
  
  return(df)
}



#### Calculate Metric



##################################################
# function: get_metric
# calculate metric for randomization test
# input: 2-column data frame for regression
# output: regression slope
#------------------------------------------------- 
get_metric <- function(z=NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <-  x_obs + 10*rnorm(20)
    z <- data.frame(x_obs,y_obs)} 
  # set up data frame                 
  . <- lm(z[,2]~z[,1])
  . <- summary(.)
  . <- .$coefficients[2,1]
  
  slope <- .
  return(slope)
}

### Create randomization


##################################################
# function: shuffle_data
# randomize data for regression analysis
# input: 2-column data frame (x_var,y_var)
# output: 2-column data frame (x_var,y_var)
#------------------------------------------------- 
shuffle_data <- function(z=NULL) {
  if(is.null(z)){
    x_obs <- 1:20
    y_obs <- x_obs + 3*rnorm(20)
    z <- data.frame(x_obs,y_obs)} # set up data frame                 
  z[,2] <- sample(z[,2]) # use sample function with defaults to reshuffle column
  
  return(z)
}


#### Calculate p value from simulated metrics


##################################################
# function: get_pval
# calculate p value from simulation
# input: list of observed metric, and vector of simulated metrics
# output: lower, upper tail probability values
#------------------------------------------------- 
get_pval <- function(z=NULL) {
  if(is.null(z)){
    z <- list(x_obs=runif(1),x_sim=runif(1000))}
  p_lower <- mean(z[[2]]<=z[[1]])
  p_upper <- mean(z[[2]]>=z[[1]])
  return(c(pl=p_lower,pu=p_upper))
}

#### Create histogram of simulated and observed metric


##################################################
# function: plot_ran_test
# create ggplot of histogram of simulated values
# input: list of observed metric and vector of simulated metrics
# output: saved ggplot graph
#------------------------------------------------- 
plot_ran_test <- function(z=NULL) {
  if(is.null(z)){
    z <- list(rnorm(1),rnorm(1000)) }
  df <- data.frame(ID=seq_along(z[[2]]),sim_x=z[[2]])
  
  p1 <- ggplot(data=df) + 
    aes(x=sim_x)
  
  p1 + geom_histogram(aes(fill=I("goldenrod"),
                          color=I("black"))) +
    geom_vline(aes(xintercept=z[[1]],
                   col="blue")) 
  
}
 
#### Now use functions to do the work


n_sim <- 1000
x_sim <- rep(NA,n_sim) # vector of simulated slopes
df <- read_data()
x_obs <- get_metric(df)

for (i in seq_len(n_sim)) {
  x_sim[i] <- get_metric(shuffle_data(df))
}

slopes <- list(x_obs,x_sim)
get_pval(slopes)
plot_ran_test(slopes)