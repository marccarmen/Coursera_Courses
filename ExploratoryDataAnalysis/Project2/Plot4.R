# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999-2008?

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

#create a list of category names containing coal
coalCats <- grep("coal", SCC$EI.Sector, value=T, ignore.case=T)
#create a list of categories using the names
coalSCC <- SCC[which(SCC$EI.Sector %in% coalCats),]
#subset the emissions data using the coal categories
coalNEI <- NEI[which(NEI$SCC %in% coalSCC$SCC),]
#use the subset data to summarize the info
summary <- ddply(coalNEI, .(year), numcolwise(sum))

#save plot to file
png("Plot4.png", width=480, height=480)
plot(summary$year, summary$Emissions, type="b", 
     main="Total US Coal Emissions", xlab="Year", ylab="Total Coal PM2.5 Emissions (tons)"
)
dev.off()