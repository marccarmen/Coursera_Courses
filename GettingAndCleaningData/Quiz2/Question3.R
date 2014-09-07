# QUIZ 2 Question 3
# Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

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

#read the data into the acs variable
acs <- read.csv('data/acs.csv')

#run the sql unique command
sqlunique <- sqldf("select distinct AGEP from acs")

#run the R unique command
runique <- unique(acs$AGEP)

#compare the two results and print out if they are equivalent
matches <- runique == sqlunique[,1]
if (sum(!matches) == 0) {
    print("Queries are equivalent")
} else {
    print("Queries are not equivalent")
    
}