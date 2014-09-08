# Quiz 4 Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
# 
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

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

#do a global substitution in the GDP column to remove ,
gdp$GDP <- gsub(",", "", gdp$GDP)
#convert GDP column to numeric
gdp$GDP <- as.numeric(gdp$GDP)
#print the mean
print(mean(gdp$GDP))