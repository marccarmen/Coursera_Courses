rankhospital <- function(state, outcome, num = "best") {
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
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
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
    num_vals <- lapply(state_data[,col_index], as.numeric)
    #convert the list structure of num_vals to a vector
    num_vals_vector <- unlist(num_vals,recursive = TRUE)
    #sort the list by value and Hospital Name
    sorted <- order(num_vals_vector, state_data$Hospital.Name)
    #get the state data in sorted and ranked order
    ranked <- state_data[sorted,]
    #determine what row we want
    #best = 1
    #word = total_rows - length(NA)
    #otherwise assume num is number
    if (num == "best") {
        num = 1
    }
    else if (num == "worst") {
        num = length(which(!is.na(lapply(ranked[,col_index], as.numeric))))
    }
    
    #return the cell at num, 2 from the ranked dataframe
    return(ranked[num, 2])
}