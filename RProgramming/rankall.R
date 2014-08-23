rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("ProgrammingAssignment3/outcome-of-care-measures.csv", colClasses="character")
    ## Check that state and outcome are valid
    #vector of valid outcome input
    poutcomes <- c("heart attack", "heart failure", "pneumonia")
    if (!(outcome %in% poutcomes)) {
        stop("invalid outcome")
    }
    #get a list of valid states
    states <- unique(data$State)
    states <- sort(states)
    
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
    
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
    #create a dataframe to return
    result <- data.frame()
    ## For each state, find the hospital of the given rank
    for (i in 1:length(states)) {
        state <- states[i]
        state_data <- data[data$State==state,]
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
            result_index = 1
        }
        else if (num == "worst") {
            result_index = length(which(!is.na(lapply(ranked[,col_index], as.numeric))))
        }
        else {
            result_index <- num
        }
        name <- ranked[result_index, 2]
        result <- rbind(result, data.frame(name, state))
    }
    names(result) <- c("hospital", "state")
    result <- result[order(result$state),]
    return(result)
}