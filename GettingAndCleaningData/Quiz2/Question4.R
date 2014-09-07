# QUIZ 2 Question 4
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
#    
#    http://biostat.jhsph.edu/~jleek/contact.html 
#
#(Hint: the nchar() function in R may be helpful)

#load the XML library
library(XML)

#setup the connection and read HTML page into the variable htmlCode...be sure to close te connection
con = url("http://biostat.jhsph.edu/~jleek/contact.html")
#read lines will read each line of the file into a vector
htmlCode = readLines(con)
close(con)

#print out the length of the required lines
print(paste("Line 10: ", nchar(htmlCode[10])))
print(paste("Line 20: ", nchar(htmlCode[20])))
print(paste("Line 30: ", nchar(htmlCode[30])))
print(paste("Line 100: ", nchar(htmlCode[100])))