# QUIZ 2 Question 5
# Read this data set into R and report the sum of the numbers in the fourth column. 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 
#
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 
#
# (Hint this is a fixed width file format)

#read in the file using a fixed with format...ignoring the first real column and grabbing each of the data columns
fwf <- read.fwf('data/item.for', c(-1,-9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
print(colSums(fwf))