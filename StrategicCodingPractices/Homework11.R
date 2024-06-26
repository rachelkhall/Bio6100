---
title: "Homework 11"
author: "Rachel Hall"
date: "April 11, 2024" 
output: html_document
editor_options: 
  chunk_output_type: console
---
kni
### Batch Processing

##### Downloading Prelims
```{r,include=FALSE}
library(dplyr)
library(sqldf)
library(tidyverse)
library(stringr)
```

##### Directory for setwd:
```{r}
setwd("/Users/rachelhall/BME 6100/Bio6100/StrategicCodingPractices/OriginalData")
working_directory<-"/Users/rachelhall/BME 6100/Bio6100/StrategicCodingPractices/OriginalData"

filelist<-list.files((working_directory))

print(filelist)

# paste0("Here is"," the"," filepath: ", filelist[1])

# Question 2 Within each year’s folder, you will only be using a file from each year labeled “countdata” in its title. Using for loops, iterate through each year’s folders to gather the file names of these “countdata” .csv files.

#1-9 because 9 folders 
filenames<-c()
for (i in 1:9) {
  setwd(paste0(working_directory, "/", filelist[i]))
  filenames[i]<-list.files(pattern="countdata")
filenames
}
print(filenames)

# Question 3 Starting with pseudo-code, generate functions for 1) Cleaning the data for any empty/missing cases, 2) Extract the year from each file name, 3) Calculate Abundance for each year (Total number of individuals found), 4) Calculate Species Richness for each year(Number of unique species found)

# Extracted the year in separate loop

fileyear<-c()
for (i in 1:9) {
  setwd(paste0(working_directory,"/", filelist[i]))
  fileyear[i]<-list.files(pattern=".20\\d{2}\\W")
  fileyear[i]<- str_extract(fileyear[i], pattern="20\\d{2}")
}
print(fileyear)

for (i in 1:9) {
  setwd(paste0(working_directory,"/", filelist[i]))
  # Cleaning up the blank lines
  data <- read.csv(filenames[i])
  data <- data[complete.cases(data$scientificName),]
  # Printing results
  cat("File:", basename(filenames[i]), "\n")
  cat("Date:", fileyear[i], "\n") 
  cat("Abundance:", nrow(data), "\n") # number of rows is the abundance
  cat("Richness:", length(unique(data$scientificName)), "\n") # Number of unique species in scientificName column
  cat("\n")
}

# 4.  Create an initial empty data frame to hold the above summary statistics-you should have 4 columns, one for the file name, one for abundance, one for species richness, and one for year.

# Empty data frame
results<- data.frame(File = character(),
                     Date=character(),
                     Abundance = numeric(),
                     Richness = numeric())


# Loop through each CSV file
for (i in 1:9) {
  setwd(paste0(working_directory,"/", filelist[i]))
  data <- read.csv(filenames[i])
  data <- data[complete.cases(data$scientificName),]
  abundance <- nrow(data)
  richness <- length(unique(data$scientificName))
  # Filling data frame while looping through filenames  
  results <- rbind(results, data.frame(File = filenames[i],
                                       Date = fileyear[i], 
                                       Abundance = abundance,
                                       Richness = richness))
}
print(results)

# 5. Using a for loop, run your created functions as a batch process for each folder, changing the working directory as necessary to read in the correct files, calculating summary statistics with your created functions, and then writing them out into your summary statistics data frame.

# I'm not sure what the difference between the table from Q4 and this would be. Summary of the files shown below:
print(results)
