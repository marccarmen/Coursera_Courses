pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)
    values = c()
    for (i in id) {
        ##construct the filename using the index and padding leading 0
        name <- formatC(i, width=3, flag="0")
        ##add the extension .csv
        filename <- paste(name, ".csv", sep="")
        ##create the full path
        file <- paste(directory, filename, sep= "/")
        ##read the file
        data <- read.csv(file)
        if (pollutant == "sulfate") {
            values <- c(values, data$sulfate)
            #print(mean(data$sulfate, na.rm=TRUE))
        }
        else {
            values <- c(values, data$nitrate)
            #print(mean(data$nitrate, na.rm=TRUE))
        }
    }
    mean(values, na.rm=TRUE)
}