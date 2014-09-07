# Quiz 1 Question 5
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
#
# using the fread() command load the data into an R object
#   DT 
# Which of the following is the fastest way to calculate the average value of the variable
#   pwgtp15 
# broken down by sex using the data.table package?

#load the data.table and microbenchmark libraries
library(data.table)
library(microbenchmark)
#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.cs"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz1"
filePath <- "data/Q5.csv"
#set the working directory
setwd(basePath)
#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}
#read the into the data.table DT
DT <- fread(filePath)

#Run each of the valid queries and benchmark them
#This query is invalid
#print(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]) #INVALID


print("---------------")
print(sapply(split(DT$pwgtp15,DT$SEX),mean))
print(microbenchmark(sapply(split(DT$pwgtp15,DT$SEX),mean), times=1000))


print("---------------")
print(DT[,mean(pwgtp15),by=SEX])
print(microbenchmark(DT[,mean(pwgtp15),by=SEX], times=1000))


print("---------------")
print(tapply(DT$pwgtp15,DT$SEX,mean))
print(microbenchmark(tapply(DT$pwgtp15,DT$SEX,mean), times=1000))


#This query is invalid
#print(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)) #INVALID
print("---------------")
print(mean(DT$pwgtp15,by=DT$SEX))
print(microbenchmark(mean(DT$pwgtp15,by=DT$SEX), times=1000))