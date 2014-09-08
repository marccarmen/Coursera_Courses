# Quiz 4 Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# In the data set from Question 2 what is a regular expression that would allow you to count the number of 
# countries whose name begins with "United"? Assume that the variable with the country names in it is 
# named countryNames. How many countries begin with United?

#load the data.table library
library(data.table)

#setup the paths and urls
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz4"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
filePath <- "data/GDP.csv"

#set the working directory
setwd(basePath)

#if the files haven't been downloaded yet then download the files
if (!file.exists(filePath)) {
    download.file(url, filePath)
}

#read the gdp file
gdp <- read.csv(filePath, header=FALSE, stringsAsFactors=FALSE)
#ignore the first 5 lines and only grab the 4 columns with data
gdp <- gdp[-1:-5,c(1, 2, 4, 5)]
#set the column names
colnames(gdp) <- c("CountryCode", "Rank", "CountryName", "GDP")
#only grab the rows that have a Rank and CountryCode (there are extra line spaces and junk rows)
gdp<-gdp[(gdp$Rank != '' & gdp$CountryCode != ''),]

#put the CountryName column into the variable countryNames
countryNames <- gdp$CountryName

#print out each test case using the correct RegEx ^United
print(table(grepl("^United",countryNames)))
#Searches for any character before United
#*United
#Searches for United at the end of the name
#United$

