# Quiz 1 Question 1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#
# and load the data into R. The code book, describing the variable names is here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# How many properties are worth $1,000,000 or more?

#load the data.table library
library(data.table)

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz1"
filePath <- "data/ACS.csv"
#set the working directory
setwd(basePath)
#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}
#read the data into the data.table acs
acs <- fread(filePath)
#According to the  code book the column VAL is for value
#and the value of 24 is 1000000000 or more
print(nrow(acs[acs$VAL==24,]))