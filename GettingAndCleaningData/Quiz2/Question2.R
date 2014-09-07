# QUIZ 2 Question 2
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the 
# dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R 
# object called acs
# 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
#
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

#load the sqldf library
library(sqldf)

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz2"
filePath <- "data/acs.csv"

#set the working directory
setwd(basePath)

#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}

#read the csv file into acs
acs <- read.csv(filePath)

#run the SQL query
print(sqldf("select * from acs where AGEP < 50 and pwgtp1"))