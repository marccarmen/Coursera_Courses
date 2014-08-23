complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    completed <- data.frame()
    for (i in id) {
        ##construct the filename using the index and padding leading 0
        name <- formatC(i, width=3, flag="0")
        ##add the extension .csv
        filename <- paste(name, ".csv", sep="")
        ##create the full path
        file <- paste(directory, filename, sep= "/")
        ##read the file
        data <- read.csv(file)
        data <- na.omit(data)
        completed<-rbind(completed, data.frame(c(i), c(nrow(data))))
    }
    names(completed) <- c("id", "nobs")
    completed
}