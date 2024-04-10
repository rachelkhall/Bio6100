# Homework 8: Data manipulations using the dplyr package 
# Rachel Hall 
# March 20, 2024

library(tidyverse)
library(dplyr)

# 1. Examine the structure of the iris data set. How many observations and variables are in the data set?

data("iris")
glimpse(iris)

# In the data set, there are 150 observations and 5 variables. 

# 2. Create a new data frame iris1 that contains only the species virginica and versicolor with sepal lengths longer than 6 cm and sepal widths longer than 2.5 cm. How many observations and variables are in the data set?

iris1 <- filter(iris, Species %in% c("virginica", "versicolor"),
                Sepal.Length > 6, Sepal.Width > 2.5)
glimpse(iris1)

# In the iris1 data set, there are 56 observations and 5 variables. 
# 3. Now, create a iris2 data frame from iris1 that contains only the columns for Species, Sepal.Length, and Sepal.Width. How many observations and variables are in the data set?

iris2 <- select(iris1, Species, Sepal.Length, Sepal.Width)
glimpse(iris2)

# In the iris2 data set, there are 56 observations and 3 variables.

# 4. Create an iris3 data frame from iris2 that orders the observations from largest to smallest sepal length. Show the first 6 rows of this data set.

iris3 <- arrange(iris2, by=desc(Sepal.Length))
head(iris3)

# 5. Create an iris4 data frame from iris3 that creates a column with a sepal area (length * width) value for each observation. How many observations and variables are in the data set?

iris4 <- mutate(iris3, Sepal.Area = Sepal.Length * Sepal.Width)
glimpse(iris4)

# In the iris4 data set, there are 56 observations and 4 variables.

# 6. Create iris5 that calculates the average sepal length, the average sepal width, and the sample size of the entire iris4 data frame and print iris5.

iris5 <- summarize(iris4, Mean_Sepal.Length = mean(Sepal.Length), 
                   Mean_Sepal.Width = mean(Sepal.Width), 
                   Sample_Size = n())
print(iris5)

# 7. Finally, create iris6 that calculates the average sepal length, the average sepal width, and the sample size for each species of in the iris4 data frame and print iris6.

iris_species <- group_by(iris4, Species)
iris6 <- summarize(iris_species,
                   Mean_Sepal.Length = mean(Sepal.Length), 
                   Mean_Sepal.Width = mean(Sepal.Width), 
                   Sample_Size = n())
print(iris6)

# 8. See if you can rework all of your previous statements (except for iris5) into an extended piping operation that uses iris as the input and generates irisFinal as the output (use the pipe operator %>% from the tidyr package).

irisFinal<- iris %>%
  filter(Species %in% c("virginica", "versicolor"),
         Sepal.Length > 6, Sepal.Width > 2.5) %>%
  select(Species, Sepal.Length, Sepal.Width) %>%
  arrange(by=desc(Sepal.Length)) %>%
  mutate(Sepal.Area = Sepal.Length * Sepal.Width) %>%
  group_by(Species) %>%
  summarize(Mean.Sepal.Length = mean(Sepal.Length),
            Mean.Sepal.Width = mean(Sepal.Width), 
            Sample_Size = n()) 

  print(irisFinal)

# 9. Create a ‘longer’ data frame using the original iris data set with three columns named “Species”, “Measure”, “Value”. The column “Species” will retain the species names of the data set. The column “Measure” will include whether the value corresponds to Sepal.Length, Sepal.Width, Petal.Length, or Petal.Width and the column “Value” will include the numerical values of those measurements.
  
# Keeping species but the four columns will be combined into the one column "measure" and then all the corresponding values will go into a column called value. 
  
irisLong<-pivot_longer(iris, cols=c(Sepal.Length, Sepal.Width, Petal.Length,Petal.Width), names_to="Measure", values_to = "Value")
head(irisLong)
