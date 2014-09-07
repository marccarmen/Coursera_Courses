# Quiz 1 Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
#
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
#    dat 
# What is the value of:
#    sum(dat$Zip*dat$Ext,na.rm=T) 
# (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

#load the excel library
library(xlsx)
#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz1"
filePath <- "data/NGAP.xlsx"
#set the working directory
setwd(basePath)
#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}
#load the excel file into dat
#speciically loading columns 7:15 and rows 18:23
dat <- read.xlsx(filePath, sheetIndex=1, header=TRUE, colIndex=7:15, rowIndex=18:23)
#print out the sum function as instructed
print(sum(dat$Zip*dat$Ext,na.rm=T) )