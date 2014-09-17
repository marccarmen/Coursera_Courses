# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
# on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as 
# described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code 
# book that describes the variables, the data, and any transformations or work that you performed to clean up 
# the data called CodeBook.md. You should also include a README.md in the repo with your scripts. 
# This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
# Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
# The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S 
# smartphone. A full description is available at the site where the data was obtained: 
#     
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#     
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Good luck!

#setup the paths and urls
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#basePath <- "C:/Users/Marc/Sync/Personal Projects/Coursera/GettingAndCleaningData/CourseProject"
basePath <- "J:/PersonalProjects/Coursera/GettingAndCleaningData/CourseProject"
filePath <- "data/Dataset.zip"

#set the working directory
setwd(basePath)

#create the data directory if it exists then warnings are blocked
dir.create("data", showWarnings=FALSE)

#create the output directory if it exists then warnings are blocked
dir.create("output", showWarnings=FALSE)

#if the file hasn't been downloaded yet the download the file
if (!file.exists(filePath)) {
    download.file(url, filePath, mode='wb')
    unzip(filePath, exdir='data')
}

#setup the needed file paths
labelsPath <- "data/UCI HAR Dataset/activity_labels.txt"
featuresPath <- "data/UCI HAR Dataset/features.txt"
trainSubjectsPath <- "data/UCI HAR Dataset/train/subject_train.txt"
trainXPath <- "data/UCI HAR Dataset/train/X_train.txt"
trainYPath <- "data/UCI HAR Dataset/train/y_train.txt"
testSubjectsPath <- "data/UCI HAR Dataset/test/subject_test.txt"
testXPath <- "data/UCI HAR Dataset/test/X_test.txt"
testYPath <- "data/UCI HAR Dataset/test/y_test.txt"

#read in the label data and set the column names
labels <- read.csv(labelsPath, header=FALSE, sep=" ")
colnames(labels) <- c("ActivityID", "ActivityName")

#read in the features column num and name
features <- read.csv(featuresPath, header=FALSE, sep=" ", colClasses=c('numeric', 'character'))

# Prettify variable names
for (i in 1:nrow(features)) 
{
    #store the cell value into a variable for easy access
    featureName <- features[i,2]
    
    #replace starting t with Time
    featureName = gsub("^t","Time",featureName)
    #replace starting f with time
    featureName = gsub("^f","Freq",featureName)
    #replace all Mag with Magnitude
    featureName = gsub("Mag","Magnitude",featureName)
    #replace all Acc with Acceleration
    featureName = gsub("Acc","Acceleration",featureName)  
    #Standardize Gravity with capital G
    featureName = gsub("gravity","Gravity",featureName)
    featureName = gsub("BodyBody","Body",featureName)
    #Standardize Gyro with capital G
    featureName = gsub("gyro","Gyro",featureName)
    
    #simply regex by replacing parens
    featureName = gsub("\\(\\)","",featureName)
    #Still use STD for Standard Deviation but prettify it
    featureName = gsub("-std","STD",featureName)
    #prettify Mean
    featureName = gsub("-mean","Mean",featureName)
    #Still use MAD for Median Absolute Deviation but prettify it
    featureName = gsub("-mad","MAD",featureName)
    #Prettify max
    featureName = gsub("-max","MAX",featureName)
    #Prettify min
    featureName = gsub("-min","MIN",featureName)
    #Still use SMA for Signal magnitude area but prettify it
    featureName = gsub("-sma","SMA",featureName)
    #Change energy to EnergyMeasure
    featureName = gsub("-energy","EnergyMeasure",featureName)
    #Still use IQR for Interquartil Range but prettify it
    featureName = gsub("-iqr","IQR",featureName)
    #Prettify entropy
    featureName = gsub("-entropy","Entropy",featureName)
    #Prettify arCoeff
    featureName = gsub("-arCoeff","AutoregressionCoefficients",featureName)
    #Prettify arCoeff
    featureName = gsub("-correlation","CorrelationCoefficient",featureName)
    #Prettify maxInds: index of the frequency component with largest magnitude
    featureName = gsub("-maxInds","IndexFrequencyLargestMagnitude",featureName)
    #Prettify meanFreq: Weighted average of the frequency components to obtain a mean frequency
    featureName = gsub("-meanFreq","MeanFrequency",featureName)
    #skewness: skewness of the frequency domain signal 
    featureName = gsub("-skewness","Skewness",featureName)
    #kurtosis: kurtosis of the frequency domain signal 
    featureName = gsub("-kurtosis","Kurtosis",featureName)
    #bandsEnergy: Energy of a frequency interval within the 64 bins of the FFT of each window.
    featureName = gsub("-bandsEnergy","BandsEnergy",featureName)
    
    #angle: Angle between to vectors.
    featureName = gsub("angle\\(","AngleBetween",featureName)
    #Remove extra parens
    featureName = gsub(")","",featureName)
    
    #set the cell value to the prettified name
    features[i,2] = featureName
}
#set the column names
colnames(features) <- c("ColumnNumber", "ColumnName")

#######TEST data#######
#read the subjects in and assign the column name
testSubjects <- read.table(testSubjectsPath, header=FALSE)
colnames(testSubjects) <- c("Subject")
#read the labels and assign the column name
testLabels <- read.table(testYPath, header=FALSE)
colnames(testLabels) <- c("ActivityID")
#use merge to correctly assign the label name to the appropriate label id
testLabels <- merge(testLabels, labels, by="ActivityID")
#read in the test data
testData <- read.table(testXPath, header=FALSE)

#######TRAIN data#######
#read in the subjects and assign the column name
trainSubjects <- read.table(trainSubjectsPath, header=FALSE)
colnames(trainSubjects) <- c("Subject")
#read the labels in and assign the column name
trainLabels <- read.table(trainYPath, header=FALSE)
colnames(trainLabels) <- c("ActivityID")
#use merge to correctly assign the label name to the appropriate label id
trainLabels <- merge(trainLabels, labels, by="ActivityID")
#read in the training data
trainData <- read.table(trainXPath, header=FALSE)

#merge the subjects, labels, and data for test and train into variables
testData <- cbind(testSubjects, testLabels, testData)
trainData <- cbind(trainSubjects, trainLabels, trainData)

#create allData that contains all of the train and test data
allData <- rbind(testData, trainData)

#assign the first 3 column names
colnames(allData)[1:3] <- c("SubjectID", "ActivityID", "ActivityName")
#assign the remainder of the column names using he features data.frame
colnames(allData)[4:ncol(allData)] <- as.character(features[,"ColumnName"])

#create a final data set that will contain the first three columns, mean(), and std() columns
finalData <- allData[,1:3]
finalData <- cbind(finalData, allData[,grepl("Mean", names(allData))])
finalData <- cbind(finalData, allData[,grepl("STD", names(allData))])

#create a tidy data set by aggregating the data by ActivityID and SubjectID 
tidyData <- aggregate(finalData[4:ncol(finalData)], by=list(ActivityID=finalData$ActivityID,SubjectID = finalData$SubjectID), mean)
#sort data by activity id and subject id
tidyData <- tidyData[order(tidyData$ActivityID, tidyData$SubjectID),]
#merge the Activity feature names back in to the data set
tidyData <- merge(labels, tidyData, by="ActivityID")
#set the column names
colnames(tidyData)[1:3] <- c("ActivityID", "Activity", "Subject")
colnames(tidyData)[4:ncol(finalData)] <- colnames(finalData)[4:ncol(finalData)]
#remove the activity ID
tidyData$ActivityID <- NULL

#get the features not used in the tidy data set
unusedFeatures <- setdiff(colnames(allData), colnames(finalData))

#setup the path for output files
finalDataPath <- "output/finalData.txt"
tidyDataPath <- "output/tidyData.txt"
allDataFeaturesPath <- "output/allDataFeatures.txt"
tinyDataFeaturesPath <- "output/tinyDataFeatures.txt"
unusedTinyDataFeaturesPath <- "output/unusedTinyDataFeatures.txt"

#write out final data and tiny data
write.table(finalData, finalDataPath, row.name=FALSE, sep=",")
write.table(tidyData, tidyDataPath, row.name=FALSE, sep=",")

#check to see if the features path exists and if so remove
if (file.exists(allDataFeaturesPath)) {
    file.remove(allDataFeaturesPath)
}
if (file.exists(tinyDataFeaturesPath)) {
    file.remove(tinyDataFeaturesPath)
}
if (file.exists(unusedTinyDataFeaturesPath)) {
    file.remove(unusedTinyDataFeaturesPath)
}

#write out features files
lapply(colnames(allData)[4:ncol(allData)], write, allDataFeaturesPath, append=TRUE)
lapply(colnames(tidyData)[3:ncol(tidyData)], write, tinyDataFeaturesPath, append=TRUE)
lapply(unusedFeatures, write, unusedTinyDataFeaturesPath, append=TRUE)

#Copy the final output to the main directory
file.copy(tidyDataPath, "tidyData.txt")