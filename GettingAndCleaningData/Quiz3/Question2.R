# Quiz 3 Question 2
# Using the jpeg package read in the following picture of your instructor into R 
#
#https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
#
#Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? 
#(some Linux systems may produce an answer 638 different for the 30th quantile)

#load the jpeg library
library(jpeg)

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/Quiz3"
filePath <- "data/jeff.jpg"

#set the working directory
setwd(basePath)

#if the file hasn't been downloaded yet then download the file
if (!file.exists(filePath)) {
    #download in binary mode
    download.file(url, filePath, mode='wb')
}

#read in the jpgg
img <- readJPEG(filePath, native=TRUE)
#generate the quantile
q <- quantile(img, probs=c(0.30, 0.80))
#print the result
print(q)