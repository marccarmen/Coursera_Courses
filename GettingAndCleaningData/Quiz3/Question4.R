# Quiz 3 Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
#
# Load the educational data from this data set: 
#    
#    https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
#
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
#
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
#   http://data.worldbank.org/data-catalog/ed-stats

#load the data.table library
library(data.table)

#setup the paths and urls
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz3"
urlGdp <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
urlEdu <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
filePathGdp <- "data/GDP.csv"
filePathEdu <- "data/EDU.csv"

#set the working directory
setwd(basePath)

#if the files haven't been downloaded yet then download the files
if (!file.exists(filePathGdp)) {
    download.file(urlGdp, filePathGdp)
}
if (!file.exists(filePathEdu)) {
    download.file(urlEdu, filePathEdu)
}

#read the gdp file
gdp <- read.csv(filePathGdp, header=FALSE, stringsAsFactors=FALSE)
#ignore the first 5 lines and only grab the 4 columns with data
gdp <- gdp[-1:-5,c(1, 2, 4, 5)]
#set the column names
colnames(gdp) <- c("CountryCode", "Rank", "CountryName", "GDP")
#only grab the rows that have a Rank and CountryCode (there are extra line spaces and junk rows)
gdp<-gdp[(gdp$Rank != '' & gdp$CountryCode != ''),]

#read in the education data
edu <- read.csv(filePathEdu)

#merge the data using countrycode (be sure all=True so that even those that are not matched )
mergedData <- merge(gdp, edu, by.x="CountryCode", by.y="CountryCode", all=TRUE)
#convert the rank column to be numeric so it properly sorts
mergedData[,2] <- as.numeric(mergedData[,2])
#print the data for High income: OECD
print(mean(mergedData[mergedData$Income.Group=='High income: OECD',2], na.rm=TRUE))
#print the mean for High income: nonOECD
print(mean(mergedData[mergedData$Income.Group=='High income: nonOECD',2], na.rm=TRUE))