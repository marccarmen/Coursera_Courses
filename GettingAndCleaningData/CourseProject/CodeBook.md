#<a name="top"/>Table of Contents

1. [Introduction](#introduction) 
    1. [Project Purpose](#projPurpose)
    2. [Project Details](#projDetails)
2. [Study Design](#studyDesign)
    1. [Outline](#outline)
    2. [Column Prettification](#ColumnPrettification)
3. [CodeBook](#codebook)
    1. [Data Set Information](#dataSetInfo)
    2. [Attribute Information](#attributeInfo)
    3. [Results Description](#results)
    4. [Features Table](#featuresTable)
    
-----

#<a name="introduction"/>Introduction
This project has been completed for the "Getting and Cleaning Data" course in the Data Science track offered on Coursera.org by John Hopkins University.

##<a name="projPurpose"/>Project Purpose
The goal of this project is to demonstrate my ability to collect, clean, and summarize a data set.  The steps taken to achieve the end result are similar to those that would be used in a professional setting when preparing data to hand off to other members of a team.

[Back to Top](#top)

##<a name="projDetails"/>Project Details
The recent news regarding smart watches demonstrates the popularity of wearable computing devices.  Currently there are a variety of devices on the market tjat are designed for professional athletes as well as the average end-user.  Smart watches is the next step in this evolution appealing to not only those that are tracking information about their daily habits and their health but also the individual in business that has a stylish watch that tracks a great deal of information.  

Details regarding the data set are available from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data set it self can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script that processes the data is available in this same directory and is named `run_analysis.R`

The sections below "Study Design" and "CodeBook" will provide additional details about how the data was cleaned and presented in a tidy data set.

[Back to Top](#top)

#<a name="studyDesign"/>Study Design
##<a name="outline"/>Outline
The `run_analysis.R` script has multiple steps in it that are outlined below

1.  If plyr library isn't available then attempt to install it
2.  Load the plyr library
3.  Download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip if it is not currently available in the `data` subdirectory
4.  Read the labels data from the `UCI HAR Dataset/activity_labels.txt` file and store the data in a data frame
    *  The labels data is a text file containing an activity identifier and an activity label
5.  Read the features data from the `UCI HAR Dataset/features.txt` file and store the data in a data frame
    *  The features data is stored in a text file containing the column number and the name
    *  The feature names are very succinct for data storage but that makes them difficult to understand.  As a result, the features names are taken are processed and prettified based on the details provided in the `UCI HAR Dataset/features_info.txt`  Specific details regarding this prettification process are available below in the subsection '[Column Prettification](#ColumnPrettification)'
6.  Read in the train data from the following files
    *  `UCI HAR Dataset/train/subject_train.txt` - Contains one subject identifier per row
    *  `UCI HAR Dataset/train/X_train.txt` - Contains one set of observations (561 features per observation) per row
    *  `UCI HAR Dataset/train/y_train.txt` - Contains one activity identifier per row
7.  Combine all of the train data into one data frame and merge in the activity name     
8.  Read in the test data from the following files
    *  `UCI HAR Dataset/test/subject_train.txt` - Contains one subject identifier per row
    *  `UCI HAR Dataset/test/X_train.txt` - Contains one set of observations (561 features per observation) per row
    *  `UCI HAR Dataset/test/y_train.txt` - Contains one activity identifier per row
9.  Combine all of the test data into one data frame and merge in the activity name 
10.  Combine the train and test data into one data frame
11.  Assign the column names previously loaded and prettified along with names for the first three columns
12. Create the required data set containing mean and standard deviation columns
    *  This new data set contains the SubjectID, ActivityID, and ActivityName columns and a subset of columns from the complete data set
    *  The subsetted columns are those containing the word Mean or STD in the column name.  The original set of measurements contained 561 features.  The subset of columns contains 86 features.
13. A tidy data set is created by
    1. aggregating the data as a mean for the ActivityID and the SubjectID
    2. removing the ActivityID column as only the human-readable ActivityName is needed
14. The tidy data set is written to a file `tidyData.txt`

[Back to Top](#top)

##<a name="ColumnPrettification"/>Column Prettification
The original data set has relatively short and informational names for each of the 561 features.  However, without a key these names can be difficult to decipher.  Because we are preparing this data to be used by another researcher we have implemented a prettification process to make the names of the columns more understandable.  The information regarding prettification was taken from the `UCI HAR Dataset/features_info.txt` file.  To make the feature names more clear uncommon abbreviations have been replaced with more common abbreviations or even full names.  In addition, the feature name will use CamelCase which means that the beginning of each new word or abbreviation is capitalized.  The basic rules for changin the names are in the list below

1. A lower case t at the beginning of a name is replaced with Time
2. A lower case f at the beginning of a name is replaced with Freq
    * Although Frequency would be more informational the abbreviation Freq is well known enough that it shouldn't cause confusion
3. The abbreviation Mag is replaced with Magnitude
4. The abbreviation Acc is replaced with Acceleration
5. The word gravity is replaced with Gravity
6. The word BodyBody with just Body.  It is not clear why there is a string BodyBody but seems unnecessary.
7. The lower case gyro with Gyro
9. Standardize Standard Deviation to be in caps STD() instead of std()
    *Leave the parentheses on STD so that it can be distinguished and greped
10. Change mean() to Mean()
    *Leave the parentheses on Mean so that it can be distinguished and greped
11. Change mad() to MAD for Median Absolute Deviation
12. Change max() to MAX for Maximum
13. Change min() to MIN for Minimum
14. Change sma() to SMA for Signal Magnitude Area
15. Change energy() to EnergyMeasure
16. Change iqr() to IQR for Interquartile Range
17. Change entropy() to Entropy
18. Change arCoeff() to AutoregressionCoefficients
19. Change correlation() to CorrelationCoefficient
20. Change maxInds to IndexFrequencyLargestMagnitude
21. Change meanFreq()to MeanFrequency
22. Change skewness() to Skewness
23. Change kurtosis() to Kurtosis
24. Change bandsEnergy() to BandsEnergy
25. Change angle(t to AngleBetween(Time 
    * This is to catch those values that have a Time component embedded inside the angle( 
25. Change angle( to AngleBetween(

[Back to Top](#top)

#<a name="codebook"/>CodeBook
In the original data set there are 561 features.  The tidy data set contains 86 of the 561 features.  See the [Features Table](#featuresTable) to see a breakdown of the features that are included in the final data set.  

The description of the data and attributes is best taken straight from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) entry for this data set.  I have included it below in [Data Set Information](#dataSetInfo) and [Attribute Information](#attributeInfo)

[Back to Top](#top)

##<a name="dataSetInfo"/>Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

[Back to Top](#top)

##<a name="attributeInfo"/>Attribute Information
For each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables.
* Its activity label.
* An identifier of the subject who carried out the experiment. 

[Back to Top](#top)

##<a name="results"/>Results Description
The final result is available in the `tidyData.txt` file.  This file is a comma delimited file that uses double-quotes (") as the string delimiter.  The first row in the result is the column headers.  There are 180 total observations (rows) of 66 variables.  The first two columns identify the activity and the subject which means there are a total of 68 columns.  In summary, the resulting matrix is 181x68

[Back to Top](#top)

##<a name="featuresTable"/>Features Table
This table is sorted first by those found in the TidyData set and second by feature name.  Because it is sorted second by name you will also see that there are some features that are repeated in the data set.  For example, `FreqBodyAccelerationBandsEnergy-1,16` is repeated 3 times. If you look at the original features list this converts back to the feature name `fBodyAcc-bandsEnergy()-1,16` which occurs 3 times as feature 311, 325, and 339.  I point this out as it is not an issue with my data processing but rather this is the original data set.  

|Feature Name|Found in TidyData|
|------------|:-----------------:|
|FreqBodyAccelerationJerkMagnitudeMean()|X|
|FreqBodyAccelerationJerkMagnitudeSTD()|X|
|FreqBodyAccelerationJerkMean()-X|X|
|FreqBodyAccelerationJerkMean()-Y|X|
|FreqBodyAccelerationJerkMean()-Z|X|
|FreqBodyAccelerationJerkSTD()-X|X|
|FreqBodyAccelerationJerkSTD()-Y|X|
|FreqBodyAccelerationJerkSTD()-Z|X|
|FreqBodyAccelerationMagnitudeMean()|X|
|FreqBodyAccelerationMagnitudeSTD()|X|
|FreqBodyAccelerationMean()-X|X|
|FreqBodyAccelerationMean()-Y|X|
|FreqBodyAccelerationMean()-Z|X|
|FreqBodyAccelerationSTD()-X|X|
|FreqBodyAccelerationSTD()-Y|X|
|FreqBodyAccelerationSTD()-Z|X|
|FreqBodyGyroJerkMagnitudeMean()|X|
|FreqBodyGyroJerkMagnitudeSTD()|X|
|FreqBodyGyroMagnitudeMean()|X|
|FreqBodyGyroMagnitudeSTD()|X|
|FreqBodyGyroMean()-X|X|
|FreqBodyGyroMean()-Y|X|
|FreqBodyGyroMean()-Z|X|
|FreqBodyGyroSTD()-X|X|
|FreqBodyGyroSTD()-Y|X|
|FreqBodyGyroSTD()-Z|X|
|TimeBodyAccelerationJerkMagnitudeMean()|X|
|TimeBodyAccelerationJerkMagnitudeSTD()|X|
|TimeBodyAccelerationJerkMean()-X|X|
|TimeBodyAccelerationJerkMean()-Y|X|
|TimeBodyAccelerationJerkMean()-Z|X|
|TimeBodyAccelerationJerkSTD()-X|X|
|TimeBodyAccelerationJerkSTD()-Y|X|
|TimeBodyAccelerationJerkSTD()-Z|X|
|TimeBodyAccelerationMagnitudeMean()|X|
|TimeBodyAccelerationMagnitudeSTD()|X|
|TimeBodyAccelerationMean()-X|X|
|TimeBodyAccelerationMean()-Y|X|
|TimeBodyAccelerationMean()-Z|X|
|TimeBodyAccelerationSTD()-X|X|
|TimeBodyAccelerationSTD()-Y|X|
|TimeBodyAccelerationSTD()-Z|X|
|TimeBodyGyroJerkMagnitudeMean()|X|
|TimeBodyGyroJerkMagnitudeSTD()|X|
|TimeBodyGyroJerkMean()-X|X|
|TimeBodyGyroJerkMean()-Y|X|
|TimeBodyGyroJerkMean()-Z|X|
|TimeBodyGyroJerkSTD()-X|X|
|TimeBodyGyroJerkSTD()-Y|X|
|TimeBodyGyroJerkSTD()-Z|X|
|TimeBodyGyroMagnitudeMean()|X|
|TimeBodyGyroMagnitudeSTD()|X|
|TimeBodyGyroMean()-X|X|
|TimeBodyGyroMean()-Y|X|
|TimeBodyGyroMean()-Z|X|
|TimeBodyGyroSTD()-X|X|
|TimeBodyGyroSTD()-Y|X|
|TimeBodyGyroSTD()-Z|X|
|TimeGravityAccelerationMagnitudeMean()|X|
|TimeGravityAccelerationMagnitudeSTD()|X|
|TimeGravityAccelerationMean()-X|X|
|TimeGravityAccelerationMean()-Y|X|
|TimeGravityAccelerationMean()-Z|X|
|TimeGravityAccelerationSTD()-X|X|
|TimeGravityAccelerationSTD()-Y|X|
|TimeGravityAccelerationSTD()-Z|X|
|AngleBetween(TimeBodyAccelerationJerkMean),GravityMean)||
|AngleBetween(TimeBodyAccelerationMean,Gravity)||
|AngleBetween(TimeBodyGyroJerkMean,GravityMean)||
|AngleBetween(TimeBodyGyroMean,GravityMean)||
|AngleBetween(X,GravityMean)||
|AngleBetween(Y,GravityMean)||
|AngleBetween(Z,GravityMean)||
|FreqBodyAccelerationBandsEnergy-1,16||
|FreqBodyAccelerationBandsEnergy-1,16||
|FreqBodyAccelerationBandsEnergy-1,16||
|FreqBodyAccelerationBandsEnergy-1,24||
|FreqBodyAccelerationBandsEnergy-1,24||
|FreqBodyAccelerationBandsEnergy-1,24||
|FreqBodyAccelerationBandsEnergy-1,8||
|FreqBodyAccelerationBandsEnergy-1,8||
|FreqBodyAccelerationBandsEnergy-1,8||
|FreqBodyAccelerationBandsEnergy-17,24||
|FreqBodyAccelerationBandsEnergy-17,24||
|FreqBodyAccelerationBandsEnergy-17,24||
|FreqBodyAccelerationBandsEnergy-17,32||
|FreqBodyAccelerationBandsEnergy-17,32||
|FreqBodyAccelerationBandsEnergy-17,32||
|FreqBodyAccelerationBandsEnergy-25,32||
|FreqBodyAccelerationBandsEnergy-25,32||
|FreqBodyAccelerationBandsEnergy-25,32||
|FreqBodyAccelerationBandsEnergy-25,48||
|FreqBodyAccelerationBandsEnergy-25,48||
|FreqBodyAccelerationBandsEnergy-25,48||
|FreqBodyAccelerationBandsEnergy-33,40||
|FreqBodyAccelerationBandsEnergy-33,40||
|FreqBodyAccelerationBandsEnergy-33,40||
|FreqBodyAccelerationBandsEnergy-33,48||
|FreqBodyAccelerationBandsEnergy-33,48||
|FreqBodyAccelerationBandsEnergy-33,48||
|FreqBodyAccelerationBandsEnergy-41,48||
|FreqBodyAccelerationBandsEnergy-41,48||
|FreqBodyAccelerationBandsEnergy-41,48||
|FreqBodyAccelerationBandsEnergy-49,56||
|FreqBodyAccelerationBandsEnergy-49,56||
|FreqBodyAccelerationBandsEnergy-49,56||
|FreqBodyAccelerationBandsEnergy-49,64||
|FreqBodyAccelerationBandsEnergy-49,64||
|FreqBodyAccelerationBandsEnergy-49,64||
|FreqBodyAccelerationBandsEnergy-57,64||
|FreqBodyAccelerationBandsEnergy-57,64||
|FreqBodyAccelerationBandsEnergy-57,64||
|FreqBodyAccelerationBandsEnergy-9,16||
|FreqBodyAccelerationBandsEnergy-9,16||
|FreqBodyAccelerationBandsEnergy-9,16||
|FreqBodyAccelerationEnergyMeasure-X||
|FreqBodyAccelerationEnergyMeasure-Y||
|FreqBodyAccelerationEnergyMeasure-Z||
|FreqBodyAccelerationEntropy-X||
|FreqBodyAccelerationEntropy-Y||
|FreqBodyAccelerationEntropy-Z||
|FreqBodyAccelerationIndexFrequencyLargestMagnitude-X||
|FreqBodyAccelerationIndexFrequencyLargestMagnitude-Y||
|FreqBodyAccelerationIndexFrequencyLargestMagnitude-Z||
|FreqBodyAccelerationIQR-X||
|FreqBodyAccelerationIQR-Y||
|FreqBodyAccelerationIQR-Z||
|FreqBodyAccelerationJerkBandsEnergy-1,16||
|FreqBodyAccelerationJerkBandsEnergy-1,16||
|FreqBodyAccelerationJerkBandsEnergy-1,16||
|FreqBodyAccelerationJerkBandsEnergy-1,24||
|FreqBodyAccelerationJerkBandsEnergy-1,24||
|FreqBodyAccelerationJerkBandsEnergy-1,24||
|FreqBodyAccelerationJerkBandsEnergy-1,8||
|FreqBodyAccelerationJerkBandsEnergy-1,8||
|FreqBodyAccelerationJerkBandsEnergy-1,8||
|FreqBodyAccelerationJerkBandsEnergy-17,24||
|FreqBodyAccelerationJerkBandsEnergy-17,24||
|FreqBodyAccelerationJerkBandsEnergy-17,24||
|FreqBodyAccelerationJerkBandsEnergy-17,32||
|FreqBodyAccelerationJerkBandsEnergy-17,32||
|FreqBodyAccelerationJerkBandsEnergy-17,32||
|FreqBodyAccelerationJerkBandsEnergy-25,32||
|FreqBodyAccelerationJerkBandsEnergy-25,32||
|FreqBodyAccelerationJerkBandsEnergy-25,32||
|FreqBodyAccelerationJerkBandsEnergy-25,48||
|FreqBodyAccelerationJerkBandsEnergy-25,48||
|FreqBodyAccelerationJerkBandsEnergy-25,48||
|FreqBodyAccelerationJerkBandsEnergy-33,40||
|FreqBodyAccelerationJerkBandsEnergy-33,40||
|FreqBodyAccelerationJerkBandsEnergy-33,40||
|FreqBodyAccelerationJerkBandsEnergy-33,48||
|FreqBodyAccelerationJerkBandsEnergy-33,48||
|FreqBodyAccelerationJerkBandsEnergy-33,48||
|FreqBodyAccelerationJerkBandsEnergy-41,48||
|FreqBodyAccelerationJerkBandsEnergy-41,48||
|FreqBodyAccelerationJerkBandsEnergy-41,48||
|FreqBodyAccelerationJerkBandsEnergy-49,56||
|FreqBodyAccelerationJerkBandsEnergy-49,56||
|FreqBodyAccelerationJerkBandsEnergy-49,56||
|FreqBodyAccelerationJerkBandsEnergy-49,64||
|FreqBodyAccelerationJerkBandsEnergy-49,64||
|FreqBodyAccelerationJerkBandsEnergy-49,64||
|FreqBodyAccelerationJerkBandsEnergy-57,64||
|FreqBodyAccelerationJerkBandsEnergy-57,64||
|FreqBodyAccelerationJerkBandsEnergy-57,64||
|FreqBodyAccelerationJerkBandsEnergy-9,16||
|FreqBodyAccelerationJerkBandsEnergy-9,16||
|FreqBodyAccelerationJerkBandsEnergy-9,16||
|FreqBodyAccelerationJerkEnergyMeasure-X||
|FreqBodyAccelerationJerkEnergyMeasure-Y||
|FreqBodyAccelerationJerkEnergyMeasure-Z||
|FreqBodyAccelerationJerkEntropy-X||
|FreqBodyAccelerationJerkEntropy-Y||
|FreqBodyAccelerationJerkEntropy-Z||
|FreqBodyAccelerationJerkIndexFrequencyLargestMagnitude-X||
|FreqBodyAccelerationJerkIndexFrequencyLargestMagnitude-Y||
|FreqBodyAccelerationJerkIndexFrequencyLargestMagnitude-Z||
|FreqBodyAccelerationJerkIQR-X||
|FreqBodyAccelerationJerkIQR-Y||
|FreqBodyAccelerationJerkIQR-Z||
|FreqBodyAccelerationJerkKurtosis-X||
|FreqBodyAccelerationJerkKurtosis-Y||
|FreqBodyAccelerationJerkKurtosis-Z||
|FreqBodyAccelerationJerkMAD-X||
|FreqBodyAccelerationJerkMAD-Y||
|FreqBodyAccelerationJerkMAD-Z||
|FreqBodyAccelerationJerkMagnitudeEnergyMeasure||
|FreqBodyAccelerationJerkMagnitudeEntropy||
|FreqBodyAccelerationJerkMagnitudeIndexFrequencyLargestMagnitude||
|FreqBodyAccelerationJerkMagnitudeIQR||
|FreqBodyAccelerationJerkMagnitudeKurtosis||
|FreqBodyAccelerationJerkMagnitudeMAD||
|FreqBodyAccelerationJerkMagnitudeMAX||
|FreqBodyAccelerationJerkMagnitudeMIN||
|FreqBodyAccelerationJerkMagnitudeSkewness||
|FreqBodyAccelerationJerkMagnitudeSMA||
|FreqBodyAccelerationJerkMagnitudeWeightedAverageFrequency||
|FreqBodyAccelerationJerkMAX-X||
|FreqBodyAccelerationJerkMAX-Y||
|FreqBodyAccelerationJerkMAX-Z||
|FreqBodyAccelerationJerkMIN-X||
|FreqBodyAccelerationJerkMIN-Y||
|FreqBodyAccelerationJerkMIN-Z||
|FreqBodyAccelerationJerkSkewness-X||
|FreqBodyAccelerationJerkSkewness-Y||
|FreqBodyAccelerationJerkSkewness-Z||
|FreqBodyAccelerationJerkSMA||
|FreqBodyAccelerationJerkWeightedAverageFrequency-X||
|FreqBodyAccelerationJerkWeightedAverageFrequency-Y||
|FreqBodyAccelerationJerkWeightedAverageFrequency-Z||
|FreqBodyAccelerationKurtosis-X||
|FreqBodyAccelerationKurtosis-Y||
|FreqBodyAccelerationKurtosis-Z||
|FreqBodyAccelerationMAD-X||
|FreqBodyAccelerationMAD-Y||
|FreqBodyAccelerationMAD-Z||
|FreqBodyAccelerationMagnitudeEnergyMeasure||
|FreqBodyAccelerationMagnitudeEntropy||
|FreqBodyAccelerationMagnitudeIndexFrequencyLargestMagnitude||
|FreqBodyAccelerationMagnitudeIQR||
|FreqBodyAccelerationMagnitudeKurtosis||
|FreqBodyAccelerationMagnitudeMAD||
|FreqBodyAccelerationMagnitudeMAX||
|FreqBodyAccelerationMagnitudeMIN||
|FreqBodyAccelerationMagnitudeSkewness||
|FreqBodyAccelerationMagnitudeSMA||
|FreqBodyAccelerationMagnitudeWeightedAverageFrequency||
|FreqBodyAccelerationMAX-X||
|FreqBodyAccelerationMAX-Y||
|FreqBodyAccelerationMAX-Z||
|FreqBodyAccelerationMIN-X||
|FreqBodyAccelerationMIN-Y||
|FreqBodyAccelerationMIN-Z||
|FreqBodyAccelerationSkewness-X||
|FreqBodyAccelerationSkewness-Y||
|FreqBodyAccelerationSkewness-Z||
|FreqBodyAccelerationSMA||
|FreqBodyAccelerationWeightedAverageFrequency-X||
|FreqBodyAccelerationWeightedAverageFrequency-Y||
|FreqBodyAccelerationWeightedAverageFrequency-Z||
|FreqBodyGyroBandsEnergy-1,16||
|FreqBodyGyroBandsEnergy-1,16||
|FreqBodyGyroBandsEnergy-1,16||
|FreqBodyGyroBandsEnergy-1,24||
|FreqBodyGyroBandsEnergy-1,24||
|FreqBodyGyroBandsEnergy-1,24||
|FreqBodyGyroBandsEnergy-1,8||
|FreqBodyGyroBandsEnergy-1,8||
|FreqBodyGyroBandsEnergy-1,8||
|FreqBodyGyroBandsEnergy-17,24||
|FreqBodyGyroBandsEnergy-17,24||
|FreqBodyGyroBandsEnergy-17,24||
|FreqBodyGyroBandsEnergy-17,32||
|FreqBodyGyroBandsEnergy-17,32||
|FreqBodyGyroBandsEnergy-17,32||
|FreqBodyGyroBandsEnergy-25,32||
|FreqBodyGyroBandsEnergy-25,32||
|FreqBodyGyroBandsEnergy-25,32||
|FreqBodyGyroBandsEnergy-25,48||
|FreqBodyGyroBandsEnergy-25,48||
|FreqBodyGyroBandsEnergy-25,48||
|FreqBodyGyroBandsEnergy-33,40||
|FreqBodyGyroBandsEnergy-33,40||
|FreqBodyGyroBandsEnergy-33,40||
|FreqBodyGyroBandsEnergy-33,48||
|FreqBodyGyroBandsEnergy-33,48||
|FreqBodyGyroBandsEnergy-33,48||
|FreqBodyGyroBandsEnergy-41,48||
|FreqBodyGyroBandsEnergy-41,48||
|FreqBodyGyroBandsEnergy-41,48||
|FreqBodyGyroBandsEnergy-49,56||
|FreqBodyGyroBandsEnergy-49,56||
|FreqBodyGyroBandsEnergy-49,56||
|FreqBodyGyroBandsEnergy-49,64||
|FreqBodyGyroBandsEnergy-49,64||
|FreqBodyGyroBandsEnergy-49,64||
|FreqBodyGyroBandsEnergy-57,64||
|FreqBodyGyroBandsEnergy-57,64||
|FreqBodyGyroBandsEnergy-57,64||
|FreqBodyGyroBandsEnergy-9,16||
|FreqBodyGyroBandsEnergy-9,16||
|FreqBodyGyroBandsEnergy-9,16||
|FreqBodyGyroEnergyMeasure-X||
|FreqBodyGyroEnergyMeasure-Y||
|FreqBodyGyroEnergyMeasure-Z||
|FreqBodyGyroEntropy-X||
|FreqBodyGyroEntropy-Y||
|FreqBodyGyroEntropy-Z||
|FreqBodyGyroIndexFrequencyLargestMagnitude-X||
|FreqBodyGyroIndexFrequencyLargestMagnitude-Y||
|FreqBodyGyroIndexFrequencyLargestMagnitude-Z||
|FreqBodyGyroIQR-X||
|FreqBodyGyroIQR-Y||
|FreqBodyGyroIQR-Z||
|FreqBodyGyroJerkMagnitudeEnergyMeasure||
|FreqBodyGyroJerkMagnitudeEntropy||
|FreqBodyGyroJerkMagnitudeIndexFrequencyLargestMagnitude||
|FreqBodyGyroJerkMagnitudeIQR||
|FreqBodyGyroJerkMagnitudeKurtosis||
|FreqBodyGyroJerkMagnitudeMAD||
|FreqBodyGyroJerkMagnitudeMAX||
|FreqBodyGyroJerkMagnitudeMIN||
|FreqBodyGyroJerkMagnitudeSkewness||
|FreqBodyGyroJerkMagnitudeSMA||
|FreqBodyGyroJerkMagnitudeWeightedAverageFrequency||
|FreqBodyGyroKurtosis-X||
|FreqBodyGyroKurtosis-Y||
|FreqBodyGyroKurtosis-Z||
|FreqBodyGyroMAD-X||
|FreqBodyGyroMAD-Y||
|FreqBodyGyroMAD-Z||
|FreqBodyGyroMagnitudeEnergyMeasure||
|FreqBodyGyroMagnitudeEntropy||
|FreqBodyGyroMagnitudeIndexFrequencyLargestMagnitude||
|FreqBodyGyroMagnitudeIQR||
|FreqBodyGyroMagnitudeKurtosis||
|FreqBodyGyroMagnitudeMAD||
|FreqBodyGyroMagnitudeMAX||
|FreqBodyGyroMagnitudeMIN||
|FreqBodyGyroMagnitudeSkewness||
|FreqBodyGyroMagnitudeSMA||
|FreqBodyGyroMagnitudeWeightedAverageFrequency||
|FreqBodyGyroMAX-X||
|FreqBodyGyroMAX-Y||
|FreqBodyGyroMAX-Z||
|FreqBodyGyroMIN-X||
|FreqBodyGyroMIN-Y||
|FreqBodyGyroMIN-Z||
|FreqBodyGyroSkewness-X||
|FreqBodyGyroSkewness-Y||
|FreqBodyGyroSkewness-Z||
|FreqBodyGyroSMA||
|FreqBodyGyroWeightedAverageFrequency-X||
|FreqBodyGyroWeightedAverageFrequency-Y||
|FreqBodyGyroWeightedAverageFrequency-Z||
|TimeBodyAccelerationAutoregressionCoefficients-X,1||
|TimeBodyAccelerationAutoregressionCoefficients-X,2||
|TimeBodyAccelerationAutoregressionCoefficients-X,3||
|TimeBodyAccelerationAutoregressionCoefficients-X,4||
|TimeBodyAccelerationAutoregressionCoefficients-Y,1||
|TimeBodyAccelerationAutoregressionCoefficients-Y,2||
|TimeBodyAccelerationAutoregressionCoefficients-Y,3||
|TimeBodyAccelerationAutoregressionCoefficients-Y,4||
|TimeBodyAccelerationAutoregressionCoefficients-Z,1||
|TimeBodyAccelerationAutoregressionCoefficients-Z,2||
|TimeBodyAccelerationAutoregressionCoefficients-Z,3||
|TimeBodyAccelerationAutoregressionCoefficients-Z,4||
|TimeBodyAccelerationCorrelationCoefficient-X,Y||
|TimeBodyAccelerationCorrelationCoefficient-X,Z||
|TimeBodyAccelerationCorrelationCoefficient-Y,Z||
|TimeBodyAccelerationEnergyMeasure-X||
|TimeBodyAccelerationEnergyMeasure-Y||
|TimeBodyAccelerationEnergyMeasure-Z||
|TimeBodyAccelerationEntropy-X||
|TimeBodyAccelerationEntropy-Y||
|TimeBodyAccelerationEntropy-Z||
|TimeBodyAccelerationIQR-X||
|TimeBodyAccelerationIQR-Y||
|TimeBodyAccelerationIQR-Z||
|TimeBodyAccelerationJerkAutoregressionCoefficients-X,1||
|TimeBodyAccelerationJerkAutoregressionCoefficients-X,2||
|TimeBodyAccelerationJerkAutoregressionCoefficients-X,3||
|TimeBodyAccelerationJerkAutoregressionCoefficients-X,4||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Y,1||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Y,2||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Y,3||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Y,4||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Z,1||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Z,2||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Z,3||
|TimeBodyAccelerationJerkAutoregressionCoefficients-Z,4||
|TimeBodyAccelerationJerkCorrelationCoefficient-X,Y||
|TimeBodyAccelerationJerkCorrelationCoefficient-X,Z||
|TimeBodyAccelerationJerkCorrelationCoefficient-Y,Z||
|TimeBodyAccelerationJerkEnergyMeasure-X||
|TimeBodyAccelerationJerkEnergyMeasure-Y||
|TimeBodyAccelerationJerkEnergyMeasure-Z||
|TimeBodyAccelerationJerkEntropy-X||
|TimeBodyAccelerationJerkEntropy-Y||
|TimeBodyAccelerationJerkEntropy-Z||
|TimeBodyAccelerationJerkIQR-X||
|TimeBodyAccelerationJerkIQR-Y||
|TimeBodyAccelerationJerkIQR-Z||
|TimeBodyAccelerationJerkMAD-X||
|TimeBodyAccelerationJerkMAD-Y||
|TimeBodyAccelerationJerkMAD-Z||
|TimeBodyAccelerationJerkMagnitudeAutoregressionCoefficients1||
|TimeBodyAccelerationJerkMagnitudeAutoregressionCoefficients2||
|TimeBodyAccelerationJerkMagnitudeAutoregressionCoefficients3||
|TimeBodyAccelerationJerkMagnitudeAutoregressionCoefficients4||
|TimeBodyAccelerationJerkMagnitudeEnergyMeasure||
|TimeBodyAccelerationJerkMagnitudeEntropy||
|TimeBodyAccelerationJerkMagnitudeIQR||
|TimeBodyAccelerationJerkMagnitudeMAD||
|TimeBodyAccelerationJerkMagnitudeMAX||
|TimeBodyAccelerationJerkMagnitudeMIN||
|TimeBodyAccelerationJerkMagnitudeSMA||
|TimeBodyAccelerationJerkMAX-X||
|TimeBodyAccelerationJerkMAX-Y||
|TimeBodyAccelerationJerkMAX-Z||
|TimeBodyAccelerationJerkMIN-X||
|TimeBodyAccelerationJerkMIN-Y||
|TimeBodyAccelerationJerkMIN-Z||
|TimeBodyAccelerationJerkSMA||
|TimeBodyAccelerationMAD-X||
|TimeBodyAccelerationMAD-Y||
|TimeBodyAccelerationMAD-Z||
|TimeBodyAccelerationMagnitudeAutoregressionCoefficients1||
|TimeBodyAccelerationMagnitudeAutoregressionCoefficients2||
|TimeBodyAccelerationMagnitudeAutoregressionCoefficients3||
|TimeBodyAccelerationMagnitudeAutoregressionCoefficients4||
|TimeBodyAccelerationMagnitudeEnergyMeasure||
|TimeBodyAccelerationMagnitudeEntropy||
|TimeBodyAccelerationMagnitudeIQR||
|TimeBodyAccelerationMagnitudeMAD||
|TimeBodyAccelerationMagnitudeMAX||
|TimeBodyAccelerationMagnitudeMIN||
|TimeBodyAccelerationMagnitudeSMA||
|TimeBodyAccelerationMAX-X||
|TimeBodyAccelerationMAX-Y||
|TimeBodyAccelerationMAX-Z||
|TimeBodyAccelerationMIN-X||
|TimeBodyAccelerationMIN-Y||
|TimeBodyAccelerationMIN-Z||
|TimeBodyAccelerationSMA||
|TimeBodyGyroAutoregressionCoefficients-X,1||
|TimeBodyGyroAutoregressionCoefficients-X,2||
|TimeBodyGyroAutoregressionCoefficients-X,3||
|TimeBodyGyroAutoregressionCoefficients-X,4||
|TimeBodyGyroAutoregressionCoefficients-Y,1||
|TimeBodyGyroAutoregressionCoefficients-Y,2||
|TimeBodyGyroAutoregressionCoefficients-Y,3||
|TimeBodyGyroAutoregressionCoefficients-Y,4||
|TimeBodyGyroAutoregressionCoefficients-Z,1||
|TimeBodyGyroAutoregressionCoefficients-Z,2||
|TimeBodyGyroAutoregressionCoefficients-Z,3||
|TimeBodyGyroAutoregressionCoefficients-Z,4||
|TimeBodyGyroCorrelationCoefficient-X,Y||
|TimeBodyGyroCorrelationCoefficient-X,Z||
|TimeBodyGyroCorrelationCoefficient-Y,Z||
|TimeBodyGyroEnergyMeasure-X||
|TimeBodyGyroEnergyMeasure-Y||
|TimeBodyGyroEnergyMeasure-Z||
|TimeBodyGyroEntropy-X||
|TimeBodyGyroEntropy-Y||
|TimeBodyGyroEntropy-Z||
|TimeBodyGyroIQR-X||
|TimeBodyGyroIQR-Y||
|TimeBodyGyroIQR-Z||
|TimeBodyGyroJerkAutoregressionCoefficients-X,1||
|TimeBodyGyroJerkAutoregressionCoefficients-X,2||
|TimeBodyGyroJerkAutoregressionCoefficients-X,3||
|TimeBodyGyroJerkAutoregressionCoefficients-X,4||
|TimeBodyGyroJerkAutoregressionCoefficients-Y,1||
|TimeBodyGyroJerkAutoregressionCoefficients-Y,2||
|TimeBodyGyroJerkAutoregressionCoefficients-Y,3||
|TimeBodyGyroJerkAutoregressionCoefficients-Y,4||
|TimeBodyGyroJerkAutoregressionCoefficients-Z,1||
|TimeBodyGyroJerkAutoregressionCoefficients-Z,2||
|TimeBodyGyroJerkAutoregressionCoefficients-Z,3||
|TimeBodyGyroJerkAutoregressionCoefficients-Z,4||
|TimeBodyGyroJerkCorrelationCoefficient-X,Y||
|TimeBodyGyroJerkCorrelationCoefficient-X,Z||
|TimeBodyGyroJerkCorrelationCoefficient-Y,Z||
|TimeBodyGyroJerkEnergyMeasure-X||
|TimeBodyGyroJerkEnergyMeasure-Y||
|TimeBodyGyroJerkEnergyMeasure-Z||
|TimeBodyGyroJerkEntropy-X||
|TimeBodyGyroJerkEntropy-Y||
|TimeBodyGyroJerkEntropy-Z||
|TimeBodyGyroJerkIQR-X||
|TimeBodyGyroJerkIQR-Y||
|TimeBodyGyroJerkIQR-Z||
|TimeBodyGyroJerkMAD-X||
|TimeBodyGyroJerkMAD-Y||
|TimeBodyGyroJerkMAD-Z||
|TimeBodyGyroJerkMagnitudeAutoregressionCoefficients1||
|TimeBodyGyroJerkMagnitudeAutoregressionCoefficients2||
|TimeBodyGyroJerkMagnitudeAutoregressionCoefficients3||
|TimeBodyGyroJerkMagnitudeAutoregressionCoefficients4||
|TimeBodyGyroJerkMagnitudeEnergyMeasure||
|TimeBodyGyroJerkMagnitudeEntropy||
|TimeBodyGyroJerkMagnitudeIQR||
|TimeBodyGyroJerkMagnitudeMAD||
|TimeBodyGyroJerkMagnitudeMAX||
|TimeBodyGyroJerkMagnitudeMIN||
|TimeBodyGyroJerkMagnitudeSMA||
|TimeBodyGyroJerkMAX-X||
|TimeBodyGyroJerkMAX-Y||
|TimeBodyGyroJerkMAX-Z||
|TimeBodyGyroJerkMIN-X||
|TimeBodyGyroJerkMIN-Y||
|TimeBodyGyroJerkMIN-Z||
|TimeBodyGyroJerkSMA||
|TimeBodyGyroMAD-X||
|TimeBodyGyroMAD-Y||
|TimeBodyGyroMAD-Z||
|TimeBodyGyroMagnitudeAutoregressionCoefficients1||
|TimeBodyGyroMagnitudeAutoregressionCoefficients2||
|TimeBodyGyroMagnitudeAutoregressionCoefficients3||
|TimeBodyGyroMagnitudeAutoregressionCoefficients4||
|TimeBodyGyroMagnitudeEnergyMeasure||
|TimeBodyGyroMagnitudeEntropy||
|TimeBodyGyroMagnitudeIQR||
|TimeBodyGyroMagnitudeMAD||
|TimeBodyGyroMagnitudeMAX||
|TimeBodyGyroMagnitudeMIN||
|TimeBodyGyroMagnitudeSMA||
|TimeBodyGyroMAX-X||
|TimeBodyGyroMAX-Y||
|TimeBodyGyroMAX-Z||
|TimeBodyGyroMIN-X||
|TimeBodyGyroMIN-Y||
|TimeBodyGyroMIN-Z||
|TimeBodyGyroSMA||
|TimeGravityAccelerationAutoregressionCoefficients-X,1||
|TimeGravityAccelerationAutoregressionCoefficients-X,2||
|TimeGravityAccelerationAutoregressionCoefficients-X,3||
|TimeGravityAccelerationAutoregressionCoefficients-X,4||
|TimeGravityAccelerationAutoregressionCoefficients-Y,1||
|TimeGravityAccelerationAutoregressionCoefficients-Y,2||
|TimeGravityAccelerationAutoregressionCoefficients-Y,3||
|TimeGravityAccelerationAutoregressionCoefficients-Y,4||
|TimeGravityAccelerationAutoregressionCoefficients-Z,1||
|TimeGravityAccelerationAutoregressionCoefficients-Z,2||
|TimeGravityAccelerationAutoregressionCoefficients-Z,3||
|TimeGravityAccelerationAutoregressionCoefficients-Z,4||
|TimeGravityAccelerationCorrelationCoefficient-X,Y||
|TimeGravityAccelerationCorrelationCoefficient-X,Z||
|TimeGravityAccelerationCorrelationCoefficient-Y,Z||
|TimeGravityAccelerationEnergyMeasure-X||
|TimeGravityAccelerationEnergyMeasure-Y||
|TimeGravityAccelerationEnergyMeasure-Z||
|TimeGravityAccelerationEntropy-X||
|TimeGravityAccelerationEntropy-Y||
|TimeGravityAccelerationEntropy-Z||
|TimeGravityAccelerationIQR-X||
|TimeGravityAccelerationIQR-Y||
|TimeGravityAccelerationIQR-Z||
|TimeGravityAccelerationMAD-X||
|TimeGravityAccelerationMAD-Y||
|TimeGravityAccelerationMAD-Z||
|TimeGravityAccelerationMagnitudeAutoregressionCoefficients1||
|TimeGravityAccelerationMagnitudeAutoregressionCoefficients2||
|TimeGravityAccelerationMagnitudeAutoregressionCoefficients3||
|TimeGravityAccelerationMagnitudeAutoregressionCoefficients4||
|TimeGravityAccelerationMagnitudeEnergyMeasure||
|TimeGravityAccelerationMagnitudeEntropy||
|TimeGravityAccelerationMagnitudeIQR||
|TimeGravityAccelerationMagnitudeMAD||
|TimeGravityAccelerationMagnitudeMAX||
|TimeGravityAccelerationMagnitudeMIN||
|TimeGravityAccelerationMagnitudeSMA||
|TimeGravityAccelerationMAX-X||
|TimeGravityAccelerationMAX-Y||
|TimeGravityAccelerationMAX-Z||
|TimeGravityAccelerationMIN-X||
|TimeGravityAccelerationMIN-Y||
|TimeGravityAccelerationMIN-Z||
|TimeGravityAccelerationSMA||

[Back to Top](#top)