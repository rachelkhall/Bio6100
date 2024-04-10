# dplyr and SQL 
# Lab March 20
# RKH

library(tidyverse)
library(sqldf) # 
#install.packages("sqldf")

# First, load in the data set from Dryad that I emailed to you: 

species_clean<-read.csv("site_by_species.csv")

var_clean<-read.csv("site_by_variables.csv")

# Take a look at the datasets first 
head(species_clean)
head(var_clean)

# Start using operations with only 1 file 

# Subsetting rows 

# dplyr: filter() method 
species<-filter(species_clean, Site<30)
var<-filter(var_clean, Site<30)

# SQL Method 
# Create a query first: sort of like a statement like a regular expression, where you're determining the dataset, what functions/actions you're doing, and any conditions for it. You then apply that query to sqldf() 

query="SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'"
sqldf(query)

# How to subset columns
# Dplyr method-uses select() function, which can use either column # or name
edit_species<-species%>%
  select(Site, Sp1, Sp2, Sp3)
edit_species_2<-species%>% #Using column #s doesn't require any indicators
  select(1, 2, 3, 4)

edit_species2<-species%>%
  select(1:4) # Using commas is the same as 1:4 

# Query the entire table in SQL

query="SELECT * FROM species"

a=sqldf(query)
sqldf(query)

# reordering columns 
query="SELECT Sp1, Sp2, Sp3, Site FROM species"
sqldf(query)

# Pivot longer and Pivot wider 
# Pivot_longer (gather) lengthens the data, decreases the number of columns, and increases the number of runs

species_long<-pivot_longer(edit_species, cols=c(Sp1, Sp2, Sp3), names_to="ID")
head(species_long)

species_wide<-pivot_wider(species_long, names_from=ID)
head(species_wide)

# SQL Method 
# Aggregate to give counts of object types 

query="
SELECT SUM(Sp1+Sp2+Sp3)
FROM species_wide
GROUP BY SITE
"

sqldf(query)

# The same as the mutate function
query="
SELECT SUM(Sp1+Sp2+Sp3) AS Occurrence 
FROM species_wide
GROUP BY SITE
"

sqldf(query)

# Mutate in SQL - create new column 
#query="
#ALTER TABLE species_wide ADD new_column VARCHAR"

#sqldf(query)

# File Operations 
# Joins: gathering data into usable formats. People will often store data into differnt variables/types of data into different fiels. As opposed to just binding things, we often need to join them together. 

# Left/Right?Union joins 
# Let's start with a clean set of files: reset the species and var variables, and filter them to a smaller size

edit_species<-species_clean%>%
  filter(Site < 30)%>%
  select(Site, Sp1, Sp2, Sp3, Longitude.x., Latitude.y.)

edit_var<-var_clean%>%
  filter(Site < 30)%>%
  select(Site, Longitude.x., Latitude.y., BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

# Left join - stitching the matching rows of file B to file A 

# dplyr method 
left<-left_join(edit_species, edit_var, by="Site")
View(left)


# right join - stitching the matching rows of file A to B. The only difference here is what is lost when you match them together.

right <-right_join(edit_species, edit_var, by="Site")

# inner_join - retain rows that match between both A and B. It loses a lot of information if the two files don't match well. 

inner<-inner_join(edit_species, edit_var, by="Site")

# Full join is opposite of inner join, it's going to  retain all values, all rows, so instead of losing many rows, you just have a bunch of NA's wherever there's missing data 

full<-full_join(edit_species, edit_var, by="Site")

# SQL Method 

query=" 
SELECT BIO1_Annual_mean_temperature,
BIO12_Annual_precipitation FROM edit_var 
LEFT JOIN edit_species ON edit_var.Site=edit_species.Site"
x<-sqldf(query)
view(x)
