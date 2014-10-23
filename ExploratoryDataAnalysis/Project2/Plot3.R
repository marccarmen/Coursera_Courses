# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.
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

NEIBaltimore <- NEI[which(NEI$fips=="24510"),]
summary <- ddply(NEIBaltimore, .(type, year), numcolwise(sum))
png("Plot3.png", width=480, height=480)
graph <- ggplot(summary, aes(x=year, y=Emissions, colour=type)) +
    geom_smooth(alpha=.2, size=1, method="loess") +
    ggtitle("Total Emissions by Type in Baltimore City") +
    labs(colour = "Type") +
    xlab("Year") +
    ylab("Emissions  (Tons of PM2.5)")
print (graph)
dev.off()
