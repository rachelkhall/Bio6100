# Usinf the assignment operator 
x <- 5 # preferred 
y = 4 #legal but not used except in function defaults 
y = y + 1.1 
print(y)
y <- y + 1.1 
 print(y)


z <-3 # Begin with lower case letter 
plantHeight <- 10 # option "camelCaseFormatting"
plant.height <- 4.2 # avoid periods
plant_height <- 3.3 # optimal "snake_case_formatting"
. <- 5.5 # reserve this for a generic temporary variable (more later)

# the combine function 
z <- c(3.2, 5, 5, 6)
print(z)
typeof(z)
is.numeric(z) # evaluates if it is numerica 

# c() always "flattens" to an atomic vector 
z <- c(c(3,4),c(5,6))
print(z)

# character strings with single or double quotes 
z <-c("perch","bass",'trout')
print(z)

# use both with an internal quote 
z <- c("This is only 'one' character string",'a second')
print(z)
typeof(z)
is.character(z)

# building logicals
# Boolean, not with quotes, all caps 
z <- c(TRUE,TRUE, FALSE)
# avoid abbreviations T, F which will work?
typeof(z)
is.logical(z)
is.integer(z)

# vector of character strings 
dogs <- c("chow","pug","beagle", "greyhoung","akita")

# use number in brackets to refer to a single element in vector. First slot is "1"
dogs[1] # picks first element 
dogs[5] # picks last element 
dogs [6] # NA, but not an error 

# pass the brackets a group of elements (= a vector) to subset the vector 
dogs[c(3,5)]

# works fine with multiple reports 
dogs[c(1,1,1,4)]
my_dogs <- c(1,4)
dogs[my_dogs]

# grab the entire list by leaving brackets blank (very useful with 2D objects)
dogs[]

# pass function to calculate the element needed 
length(dogs)
dogs[5]
dogs[length(dogs)]

# use negative numbers to exclude elements 
dogs[-1]

# ok to use multiple negations
dogs[c(-2,-4)]
dogs[-c(2,4)]

#can't mix positive and negative elements in brackets
#dogs[c(1,-5)] - gives an error

z <- c(1.1, 1.2, 3, 4.4)
typeof(z) # gives type 
is.numeric(z) # is. gives logical 
as.character(z) # as. coerces variable 
print(z)
typeof(z)

length(z) # gives number of elements 
#length(y_not) # throws error if variable does not exist

# Type and length will always be present for any vector we have. There is a third possibility that is Names

z <- runif(5)
print(z)
# optional attribute not initially assigned 
names(z)
print(z)
# add names later after variable is created
names(z) <- c("chow","pug","beagle", "greyhound","akita")
print(z)

# add names when variable is built (with or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2)
print(z2)

# reset names 
names(z2) <- NULL
print(z2)

# names can be added for only a few elements 
# names do not have to be distinct, but often are 
names(z2) <- c("copper", "zinc")
print(z2)
names(z2) <- c("copper", NA, "lead")
print(z2)

# NA values for missing data 
z <- c(3.2,3.3,NA) # NA is a missing value 
typeof(z)
length(z)
typeof(z[3]) # what is the type of the third element in that vector

z1 <- NA
typeof(z1) # different NA types 


is.na(z) # logical operator to find missing values 
mean(z) # won't work because of NA
is.na(z) # evaluate to find missing values 
!is.na(z) # use ! for NOT missing values 
mean(!is.na(z)) # wrong answer based on TRUE FALSE!!
mean(z[!is.na(z)]) # correct use of indexing 

# NaN, -Inf, and Inf from numeric division 
z <- 0/0 # now double
typeof(z)
z <- 1/0 # Inf 
print(z)
-1/0 # -Inf

# NULL is an object that is nothing 
# a reserved word in R 
z <- NULL
typeof(z)
length(z)
is.null(z) # only operation that works on a null 

# All atomics are of the same type 
# if they are different, R coerces them
# logical -> integer -> double -> character 

a <- c(2, 2.0)
print(a)
typeof(a) # technically integer coerced into numeric 

b <- c("purple","green")
typeof(b) 

d <- c(a,b) 
print(d)
typeof(d)

# "Mistakes" in numeric variables convert to strings
# Very useful when working with logical variables

a <- runif(10)
print(a)

# Comparison operators yield a logical result
a > 0.5

# do math on a logical and it coerces to an integer!

# How many elements are greater than 0.5?
sum(a > 0.5)

# What proportion of the vector elements are greater than 0.5?

mean(a > 0.5)

# Break down the result
. <- a > 0.5

print(.)
. <- as.integer(.)
print(.)
print(sum(.))
print(mean(.))

#Qualifying exam question! Approximately what proportion of observations drawn from a normal (0,1) distribution are larger than 2.0?

mean(rnorm(1000) > 2)

# adding a constant to a vector
z <- c(10,20,30)
z + 1

# what happens when vectors are added?

y <- c(1,2,3)
z + y

# results is an "element by element" operation on the vector
# most vector operations can be done this way

z^2

# Recycling
# but what if vector lengths are not equal?
z <- c(10,20,30)
x <- c(1,2)
z + x

# warning is issued by calculation is still made
# shorter vector is always "recycled"
# works with scalars (= vector of length(1))
