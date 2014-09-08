# Quiz 4 Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded 
# companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get 
# the times the data was sampled.
#   library(quantmod)
#   amzn = getSymbols("AMZN",auto.assign=FALSE)
#   sampleTimes = index(amzn) 
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

#load the necessary libraries quantmod and lubridate
library(quantmod)
library(lubridate)
#get the symbol data for amazon
amzn = getSymbols("AMZN",auto.assign=FALSE)
#get sample data for Amazon
sampleTimes = index(amzn)

#subset the data that is in 2012
twelve <- sampleTimes[grep("2012-", sampleTimes)]
#print the count
print(length(twelve))
#print out the number where the day was a monday using wday command from lubridate
print(length(which(wday(twelve, label=TRUE)=="Mon")))
