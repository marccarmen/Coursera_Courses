#Getting and Cleaning Data Course Project
This repository contains the files used for completing the project.  Specifically the `run_analysis.R` script, `README.md`, and `CodeBook.md`.  The purpose of the project and instructions regarding this code base are below.
##Overview
The purpose of this project is to demonstrate my ability to take a raw data set, clean it, and output a more meaningful data set.  The `run_analysis.R` script in this project is all you need.  Before you run the script please open it and edit the `basePath` variable.  You will want to set this to whatever path you have the `run_analysis.R` script in.  Once you have done that you can run the script and it will take care of creating any needed directories and downloading the data (if it has not been downloaded already).

A complete description of the project and what the script does is available in the CodeBook file `CodeBook.md`.

##Code Summary
A basic summary of the what the code does is below.
1. Create `data` and `output` directories if necessary
2. Download the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and store the file in the `data` directory if necessary
3. Unzip the data if necessary
4. Read and process the labels to make human readable labels
5. Read in the train and test data
6. Merge it into one data set
7. Create a data set containing mean and standard deviation data
8. Create a tidy data set containing the mean for each subject/activity combination
9. Write out the output files

##Output
All resulting files will be written to the output directory.  There are 5 files that are written out.
1. allDataFeatures.txt - A list of all features in the data set with cleaned up names.
2. finalData.txt - The merged data set with all features.
3. tidyData.txt - The aggregate data set
4. tidyDataFeatures.txt - The features that are available in the tidy data set.
5. unusedTidyDataFeatures.txt - The features that are excluded from the tidy data set.

