# GitHub URL: https://github.com/marccarmen/Coursera_Courses/blob/master/ExploratoryDataAnalysis/Project2/Plot5.R
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

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
#subset the data for Baltimore City
NEIBaltimore <- NEI[which(NEI$fips=="24510"),]
#subset the data again for those rows that are for road vehicles
subsetNEI <- NEIBaltimore[which(NEIBaltimore$SCC %in% categoryRows$SCC),]
#summarize the data
summary <- ddply(subsetNEI, .(year), numcolwise(sum))

#save plot to file
png("Plot5.png", width=480, height=480)
plot(summary$year, summary$Emissions, type="b", 
     main="Automobile Emissions in Baltimore City", xlab="Year", ylab="Total Automobile PM2.5 Emissions (tons)"
)
dev.off()
