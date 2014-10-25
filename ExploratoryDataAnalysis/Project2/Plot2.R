# GitHub URL: https://github.com/marccarmen/Coursera_Courses/blob/master/ExploratoryDataAnalysis/Project2/Plot2.R
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.
library(plyr)

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

#subset the data for Balitmore City
NEIBaltimore <- NEI[which(NEI$fips=='24510'),]
#get a summary of emissions by year using Baltimore subset
summary <- ddply(NEIBaltimore, .(year), numcolwise(sum))

#save plot to file
png("Plot2.png", width=480, height=480)
plot(summary$year, summary$Emissions, type="b", 
     main="Total Emissions for Baltimore, Maryland", xlab="Year", ylab="Total PM2.5 Emissions (tons)"
)
dev.off()
