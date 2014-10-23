# Make a bar chart of Global Active Power killowatts v frequency 
# using the data available 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# This is a self contained R script that will 
#   1) Download the data if necessary
#   2) Read in the data set
#   3) Subset the data
#   4) Produce the chart
#
# To use the script on your own computer you need to change the variable
# basePath to the directory this script is found in

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/ExploratoryDataAnalysis/Project1"
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

#setup the needed file paths
powerConPath <- "data/household_power_consumption.txt"

setup an as method to convert the date and time to date and time objects
#This will produce an error "in method for 'coerce' with signature '"character","asDate"': no definition for class "asDate"
#but will be successful anyways
setAs("character","asDate", function(from) as.Date(from, format="%d/%m/%Y"))

#read in the data
powerCon <- read.csv(powerConPath, header=T, sep=";", colClasses=c('asDate', 'character', 
                                                                  'numeric', 'numeric', 'numeric', 
                                                                  'numeric', 'numeric', 'numeric'),
                    na.strings=c('?'))

#subset the data to only get the data between 2007/02/01 and 2007/02/02
subsetData <- subset(powerCon, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

#produce the graph
png("plot1.png", width=480, height=480)
hist(subsetData$Global_active_power, main="Global Active Power", col="Red", xlab="Global Active Power (kilowatts)")
dev.off()