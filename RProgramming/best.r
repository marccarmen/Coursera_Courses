best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("ProgrammingAssignment3/outcome-of-care-measures.csv", colClasses="character")
    ## Check that state and outcome are valid
    #get a list of valid states
    states <- unique(data$State)
    #vector of valid outcome input
    poutcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!(state %in% states)) {
        stop("invalid state")
    }
    if (!(outcome %in% poutcomes)) {
        stop("invalid outcome")
    }
    ## Return hospital name in that state with lowest 30-day death
    ## rate
    #subset only the data for state
    state_data <- data[data$State==state,]
    
    #determine which column index to use...easier than using the 
    #column headings as they are so long
    if (outcome == "heart attack") {
        col_index = 11
    }
    else if (outcome == "heart failure") {
        col_index = 17
    }
    else if (outcome == "pneumonia") {
        col_index = 23
    }
    
    #convert the ratings to numeric 
    #this could raise warnings for rows that are converted to NAS by coercion
    vals <- lapply(state_data[,col_index], as.numeric)
    #convert the list structure of vals to a vector
    vals_vector <- unlist(vals,recursive = TRUE)
    #find the lowest value
    low <- min(vals_vector, na.rm=TRUE)
    #get the row index for the low
    #use vals_vector because low is an int and state_data[,col_index] contains strings
    #in this case the string 12.0 gets converted to the int 12 which will not match
    row_index = which(vals_vector==low)
    #return the hospital name for that row
    return(state_data[row_index,2])
}