# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
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

#setup paths for the two data files
emissionsPath <- "data/summarySCC_PM25.rds"
classificationPath <- "data/Source_Classification_Code.rds"

#read in emissions data and categories
NEI <- readRDS(emissionsPath)
SCC <- readRDS(classificationPath)

#create a list of categories containing the text Mobile - On-Road
#according to section 4.6 http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf 
#all automobile data has a EIS Sector beginning with Mobile - On-Road
categoryNames <- grep("Mobile - On-Road", SCC$EI.Sector, value=T, ignore.case=T)
#get the category rows using the names
categoryRows <- SCC[which(SCC$EI.Sector %in% categoryNames),]

#use emissions data to subset for baltimore
NEIBaltimore <- NEI[which(NEI$fips=="24510"),]
#subset the data for automobile
subsetBaltimore <- NEIBaltimore[which(NEIBaltimore$SCC %in% categoryRows$SCC),]
#summarize the baltimore data
summaryBaltimore <- ddply(subsetBaltimore, .(fips, year), numcolwise(sum))

#use emissions data to subset for los angeles
NEILosAngeles <- NEI[which(NEI$fips=="06037"),]
#subset the data for automobile
subsetLosAngeles <- NEILosAngeles[which(NEILosAngeles$SCC %in% categoryRows$SCC),]
#summarize the los angeles data
summaryLosAngeles <- ddply(subsetLosAngeles, .(fips, year), numcolwise(sum))

#combine the two data sets
finalDataSet <- rbind(summaryBaltimore, summaryLosAngeles)
#replace zip code with names
finalDataSet$fips[finalDataSet$fips=="24510"] <- "Baltimore City"
finalDataSet$fips[finalDataSet$fips=="06037"] <- "Los Angeles"

#save plot to file
png("Plot6.png", width=480, height=480)
graph <- ggplot(finalDataSet, aes(x=year, y=Emissions, colour=fips)) +
    geom_smooth(alpha=.2, size=1, method="loess") +
    ggtitle("Total Automobile Emissions for Baltimore City vs Los Angeles") +
    labs(colour = "City") +
    xlab("Year") +
    ylab("Total PM2.5 Emissions (tons)")
print (graph)
dev.off()
