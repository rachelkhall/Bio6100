# Homework 11

setwd("/Users/rachelhall/BME 6100/Bio6100/StrategicCodingPractices/OriginalData")

filelist<-list.files(("/Users/rachelhall/BME 6100/Bio6100/StrategicCodingPractices/OriginalData"))

filelist

paste0("Here is"," the"," filepath: ", filelist[1])

#1-6 because 6 folders 

filenames<-c()
for (i in 1:9) {
  setwd(paste0("/Users/rachelhall/BME 6100/Bio6100/StrategicCodingPractices/OriginalData", "/", filelist[i]))
  filenames[i]<-list.files(pattern="countdata")
}

filenames
