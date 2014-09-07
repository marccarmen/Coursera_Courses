# Quiz 1 Question 4
# Read the XML data on Baltimore restaurants from here: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#
# How many restaurants have zipcode 21231?

#load the XML library
library(XML)
#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz1"
filePath <- "data/restaurants.xml"
#set the working directory
setwd(basePath)
#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath)
}
#read the xml file into doc
doc <- xmlTreeParse(filePath, useInternal=TRUE)
#run the xpath query to get all of the zipcode elements with 21231 into result
result <- xpathSApply(doc, "//response/row/row/zipcode[text()='21231']", xmlValue)
#print the length of the result
print(length(result))