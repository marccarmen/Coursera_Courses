#Quiz 4 Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey 
# about housing for the state of Idaho using download.file() from here: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#    
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

#load the data.table library
library(data.table)

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv "
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz4"
filePath <- "data/2006IdahoHousing.csv"

#set the working directory
setwd(basePath)

#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}

#read in the file as a data.table
idaho <- fread(filePath)

#check to see what the column name is before the split
print(names(idaho)[123])

#split the names
splitNames = strsplit(names(idaho), "wgtp")
print(splitNames[123])