# GitHub URL: https://github.com/marccarmen/Coursera_Courses/blob/master/ExploratoryDataAnalysis/Project2/Plot1.R
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
# make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/ExploratoryDataAnalysis/Project2"
filePath <- "data/Dataset.zip"

#set the working directory
setwd(basePath)

#create the data directory if it exists then warnings are blocked
dir.create("data", showWarnings=FALSE)

#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath, mode='wb')
    unzip(filePath, exdir='data')
}

#setup paths for the two data files
emissionsPath <- "data/summarySCC_PM25.rds"
classificationPath <- "data/Source_Classification_Code.rds"

#read in emissions data
NEI <- readRDS(emissionsPath)

#get a summary of emissions by year
summary <- ddply(NEI, .(year), numcolwise(sum))

#save plot to file
png("Plot1.png", width=480, height=480)
plot(summary$year, summary$Emissions, type="b", 
     main="Total US Emissions", xlab="Year", ylab="Total PM2.5 Emissions (tons)"
     )
dev.off()
