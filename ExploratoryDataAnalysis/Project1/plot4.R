# Make a graphic containing 4 graphs
#   1) Global Active Power over time
#   2) Voltage over time
#   3) Sub metering over time
#   4) Global Reactive Power over time
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

#setup an as method to convert the date and time to date and time objects
#This will produce an error "in method for 'coerce' with signature '"character","asDate"': no definition for class "asDate"
#but will be successful anyways
setAs("character","asDate", function(from) as.Date(from, format="%d/%m/%Y"))

#read in the data
powerCon <- read.csv(powerConPath, header=T, sep=";", colClasses=c('asDate', 'character', 'numeric', 
                                                                   'numeric', 'numeric', 'numeric', 
                                                                   'numeric', 'numeric', 'numeric'),
                     na.strings=c('?'))

#subset the data to only get the data between 2007/02/01 and 2007/02/02
subsetData <- subset(powerCon, Date >= as.Date('2007-02-01') & Date <= as.Date('2007-02-02'))

#combine date and time into one column
subsetData$DateTime <- as.POSIXct(paste(subsetData$Date, subsetData$Time))

#produce the graph
png("plot4.png", width=480, height=480)
#setup the image to have 4 graphs
par(mfrow=c(2,2))
plot(subsetData$Global_active_power~subsetData$DateTime, type='l', ylab="Global Active Power", xlab="")
plot(subsetData$Voltage~subsetData$DateTime, type='l', ylab="Voltage", xlab="datetime")
plot(subsetData$Sub_metering_1~subsetData$DateTime, type='l', ylab="Energy sub metering", xlab="")
lines(subsetData$Sub_metering_2~subsetData$DateTime, col="Red")
lines(subsetData$Sub_metering_3~subsetData$DateTime, col="Blue")
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1,
       lwd=2.5, 
       col=c("Black", "Red", "Blue"))
plot(subsetData$Global_reactive_power~subsetData$DateTime, type='l', ylab="Global_reactive_power", xlab="datetime")
dev.off()