source("complete.R")
       
corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    files <- list.files(directory)
    correlations <- c()
    for (i in 1:length(files)) {
        completed <- complete(directory, i)
        if (completed$nobs > threshold) {
            #print(completed$nobs)
            ##construct the filename using the index and padding leading 0
            name <- formatC(i, width=3, flag="0")
            ##add the extension .csv
            filename <- paste(name, ".csv", sep="")
            ##create the full path
            file <- paste(directory, filename, sep= "/")
            ##read the file
            data <- read.csv(file)
            #add data to combined
            correlations <- c(correlations, cor(data$sulfate, data$nitrate, use="complete"))
        }
    }
    
    if (length(correlations) == 0) {
        correlations = vector(mode="numeric", length=0)
    }
    
    return(correlations)
}