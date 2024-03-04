# Homework 4 
# Rachel Hall 
# 7 Feb 2024

# Question 1
x <-1.1
print(x)
a <-2.2
print(a)
b <- 3.3
print(b)

# Question 1a
z <- x^(a^b)
print(z)

# Question 1b
z <- (x^a)^b
print(z)

# Question 1c
z <- (3*(x^3))+(2*(x^2))+1 
print(z)

# Question 2a
a2 <- c(1:8,seq(7,1,-1))
print(a2)

# Question 2b
b2 <- seq(1,5)
print(b2)
rep(x=b2,times=b2)

# Question 2c
b2 <- seq(1,5)
c2 <- seq(5,1)
rep(x=c2,times=b2)
# or rep(1:5.5:1)

# Question 3
set.seed(10)
x2 <- runif(2)
print(x2)
# Finding the hypotenuse
r <- sqrt(x2[1]^2+x2[2]^2)
print(r)
# Finding the angle of the vector (in radians)
theta <- asin(x2[2]/r)
print(theta)

polarcoords <-c(r, theta)
print(polarcoords)

#Question 4
queue <- c("sheep", "fox", "owl", "ant")
print(queue)

# 4a: Serpent gets in line 
queue[5] <- ("serpent")
print(queue)

# 4b:The sheep enters the ark (gets out of line)
queue <- queue[-1]
print(queue)

# 4c:The donkey arrives and talks his way to the front of the line.
queue <- c("donkey", queue)
print(queue)

# 4d:The serpent gets impatient and leaves.
queue <- queue[-5]
print(queue)

# 4e:The owl gets bored and leaves.
queue <- queue[-3]
print(queue)

# 4f:The aphid arrives and the ant invites him to cut in line.
queue <- c(queue[1], queue[2], "aphid", queue[3])
print(queue)

# 4g:Finally, determine the position of the aphid in the line.
which(queue == "aphid")

# Question 5
vec <- seq(1:100)
print(vec)

vec <- vec[vec %% 2 !=0 & vec%%3 !=0 & vec%%7 !=0]
print(vec)

