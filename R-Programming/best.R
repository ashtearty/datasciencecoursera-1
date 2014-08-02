# Source: https://github.com/arunsimha/ProgrammingAssignment3/blob/master/best.R

# best function takes state and outcome as inputs
# returns name of the hospital with best outcome

# Using submit() script passes Test 1 and Test 2, fails on Test 3 best 
# ("TX", "pneumonia")
# not taking care of NA and Not Availables properly

# Finding the best hospital in a state

# Write a function called best that take two arguments: the 2-character abbreviated name of a state and an
# outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
# with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
# in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
# be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
# outcome should be excluded from the set of hospitals when deciding the rankings.
# Handling ties. If there is a tie for the best hospital for a given outcome, then the hospital names should
# be sorted in alphabetical order and the first hospital in that set should be chosen (i.e. if hospitals “b”, “c”,
# and “f” are tied for best, then hospital “b” should be returned).

best <- function(state, outcome) {
    
    ## Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Define baseline, 
    valid_outcomes <- c("heart attack", "heart failure", "pneumonia")  #3 diseases
    valid_column <- c(11, 17, 23)    # corresponding columns for data; improve later 
    valid_state <- as.character(unique(outcome_data$State))      # 54 states, terri
    
    # then check that state and outcome are valid
    if ((state %in% valid_state) == FALSE) stop ("Invalid state")
    if ((outcome %in% valid_outcomes) == FALSE) stop ("Invalid outcome")
    
    #Assign the right valid_column based on outcome
    if (outcome == "heart attack") valid_column = 3
    if (outcome == "heart failure") valid_column = 4
    if (outcome == "pneumonia") valid_column = 5
    
    #coerce outcome_data to be as.numeric
    #outcome_data[, valid_column] <- as.numeric(outcome_data[, valid_column])
    
    # drop columns to create a manageable data frame
    outcome_data <- outcome_data[-c(1, 3:6, 8:10, 12:16, 18:22, 24:47)]
    
    # Filter data by state and outcome
    bystate_data <- subset(outcome_data, State == state, select= c(1,valid_column))
    
    # find order by outcome [column 2], find ways to eliminate NAs, Not Available na.last=NA
    index <- order(xtfrm(bystate_data[,2]), decreasing = FALSE, na.last = NA)
    
    #Order by outcome then hospital
    ordered_bystate_data <- bystate_data[index, ]
    
    # return first row's hospital name in that state with lowest 30-day death rate
    return(ordered_bystate_data[1, 1])
}