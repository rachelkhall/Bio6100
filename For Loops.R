# For Loops II
# March 28 2024
# RKH 

### Extensions of the model for realistic populations
# discrete integers to represent counts of individuals (use `round()`)
# extinction of sexually reproducing population if all same sex (use `unisexExtinct == runif(1) <= 2*(0.5)^n`
# add environmental noise that is not a random walk (add rnorm(0,1))
# add measurement error (add rnorm(0,1)) for 0s without extinction


### Using double for loops


m <- matrix(round(runif(20),digits=2),nrow=5)
# loop over rows
for (i in 1:nrow(m)) { # could use for (i in seq_len(nrow(m)))
  m[i,] <- m[i,] + i
} 
print(m)

# Loop over columns
m <- matrix(round(runif(20),digits=2),nrow=5)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}
print(m)

# Loop over rows and columns
m <- matrix(round(runif(20),digits=2),nrow=5)
for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + i + j
  } # end of column j loop
} # end or row i loop
print(m) 

# S = cA^z species area function, but what does it look like??
# creates power function relationship for S and A
# input: A is a vector of island areas
#        c is the intercept constant
#        z is the slope constant
# output: S is a vector of species richness values

species_area_curve <- function(A=1:5000,c= 0.5,z=0.26){
  
  S <- c*(A^z)
  return(S)
}
head(species_area_curve())

# function: species_area_plot
# plot species area curves with parameter values
# input: A = vector of areas
#        c = single value for c parameter
#        z = single value for z parameter

# output: smoothed curve with parameters in graph


species_area_plot <- function(A=1:5000,c= 0.5,z=0.26) {
  plot(x=A,y=species_area_curve(A,c,z),type="l",xlab="Island Area",ylab="S",ylim=c(0,2500))
  mtext(paste("c =", c,"  z =",z),cex=0.7) 
  #      return()
}
species_area_plot()

# global variables
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)
par(mfrow=c(3,4))
for (i in seq_along(c_pars)) {
  for (j in seq_along(z_pars)) {
    species_area_plot(c=c_pars[i],z=z_pars[j])
  }
} 
par(mfrow=c(1,1))

# looping with for
cut_point <- 0.1
z <- NA
ran_data <- runif(100)
for (i in seq_along(ran_data)) {
  z <- ran_data[i]
  if (z < cut_point) break
}
print(z)

# looping with while

z <- NA
cycle_number <- 0
while (is.na(z) | z >= cut_point) {
  z <- runif(1)
  cycle_number <- cycle_number + 1
  
}
print(z)
print(cycle_number)

# looping with repeat

z <- NA
cycle_number <- 0

repeat {
  z <- runif(1)
  cycle_number <- cycle_number + 1
  
  if (z <= cut_point) break
}
print(z)
print(cycle_number)

# add code for cycle number
# try setting limit to 0.001

expand.grid(c_pars,z_pars)


# function: sa_output
# Summary stats for species-area power function
# input: vector of predicted species richness 
# output: list of max-min, coefficient of variation 
#------------------------------------------------- 
sa_output <- function(S=runif(1:10)) {
  
  sum_stats <- list(s_gain=max(S)-min(S),s_cv=sd(S)/mean(S))
  
  return(sum_stats)
}
sa_output()

# Build program body with a single loop through 
# the parameters in modelFrame

# Global variables
area <- 1:5000
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# set up model frame
model_frame <- expand.grid(c=c_pars,z=z_pars)
model_frame$s_gain <- NA
model_frame$s_cv <- NA
print(model_frame)

# cycle through model calculations
for (i in 1:nrow(model_frame)) {
  
  # generate S vector
  temp1 <- species_area_curve(A=area,
                              c=model_frame[i,1],
                              z=model_frame[i,2])
  # calculate output stats
  temp2 <- sa_output(temp1)
  # pass results to columns in data frame
  model_frame[i,c(3,4)] <- temp2
  
}
print(model_frame)

library(ggplot2)

area <- 1:5 #keep this very small initially
c_pars <- c(100,150,175)
z_pars <- c(0.10, 0.16, 0.26, 0.3)

# set up model frame
model_frame <- expand.grid(c=c_pars,z=z_pars,A=area)
model_frame$S <- NA


# loop through the parameters and fill with SA function

for (i in 1:length(c_pars)) {
  for (j in 1:length(z_pars)) {
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j],"S"] <-   species_area_curve(A=area,c=c_pars[i],z=z_pars[j])
  }
}
for (i in 1:nrow(model_frame)) {
  model_frame[i,"S"] <- species_area_curve(A=model_frame$A[i],
                                           c=model_frame$c[i],
                                           z=model_frame$z[i])
}
# print(modelFrame) # check by printing a data frame with limited parameter values

library(ggplot2)

p1 <- ggplot(data=model_frame)
p1 + geom_line(mapping= aes(x=A,y=S)) +
  facet_grid(c~z)

p2 <- p1
p2 + geom_line(mapping=aes(x=A,y=S,group=z)) +
  facet_grid(.~c)

p3 <- p1
p3 + geom_line(mapping=aes(x=A,y=S,group=c)) +
  facet_grid(z~.)
