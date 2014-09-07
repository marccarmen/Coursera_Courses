# Quiz 3 Question 1
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
#
# and load the data into R. The code book, describing the variable names is here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of 
# agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like 
# this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the 
# first 3 values that result?

#load the data.table library
library(data.table)

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz3"
filePath <- "data/2006IdahoHousing.csv"

#set the working directory
setwd(basePath)

#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}

#read in the file as a data.table
idaho <- fread(filePath)
#subset those that are larger than 10 acres and who sold more than 10000
agricultureLogical <- with(idaho, ACR==3 & AGS==6)
#print our result
print(which(agricultureLogical))
