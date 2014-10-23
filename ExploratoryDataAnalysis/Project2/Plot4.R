# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?
library(plyr)
library(ggplot2)

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

emissionsPath <- "data/summarySCC_PM25.rds"
classificationPath <- "data/Source_Classification_Code.rds"

NEI <- readRDS(emissionsPath)
SCC <- readRDS(classificationPath)

#create a list of categories containing coal
coalCats <- grep("coal", SCC$EI.Sector, value=T, ignore.case=T)
coalSCC <- SCC[which(SCC$EI.Sector %in% coalCats),]
coalNEI <- NEI[which(NEI$SCC %in% coalSCC$SCC),]

summary <- ddply(coalNEI, .(year), numcolwise(sum))
#png("Plot4.png", width=480, height=480)
plot(summary$year, summary$Emissions, type="b", 
     main="Total US Coal Emissions", xlab="Year", ylab="Total Coal Emissions (Tons of PM2.5)"
)
#dev.off()