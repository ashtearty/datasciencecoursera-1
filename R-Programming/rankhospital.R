# source : https://github.com/Shekeen/Computing-For-Data-Analysis-Class/tree/master/ProgAssignment2-data

# Ranking hospitals by outcome in a state
#
# Write a function called rankhospital that takes three arguments: the 2-character abbreviated name of a
# state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
# The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
# of the hospital that has the ranking specified by the num argument. For example, the call
# rankhospital("MD", "heart failure", 5)
# would return a character vector containing the name of the hospital with the 5th lowest 30-day death rate
# for heart failure. The num argument can take values “best”, “worst”, or an integer indicating the ranking
# (smaller numbers are better). If the number given by num is larger than the number of hospitals in that
# state, then the function should return NA. Hospitals that do not have data on a particular outcome should
# be excluded from the set of hospitals when deciding the rankings.
#
# Handling ties. It may occur that multiple hospitals have the same 30-day mortality rate for a given cause
# of death. In those cases ties should be broken by using the hospital name. For example, in Texas (“TX”),
# the hospitals with lowest 30-day mortality rate for heart failure are shown here.

rankhospital <- function(state, outcome, num = "best") {
    full_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    
    column <- if (outcome == "heart attack") {
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else if (outcome == "pneumonia") {
        "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else {
        stop("invalid outcome")
    }
    
    data_for_state <- full_data[full_data$State == state, c("Hospital.Name", column)]
    
    if (nrow(data_for_state) == 0) {
        stop("invalid state")	
    }
    
    data_for_state[,2] <- as.numeric(data_for_state[,2])
    ordered_data_for_state <- order(data_for_state[column], data_for_state$Hospital.Name, na.last=NA)
    
    if (num == "best") {
        as.character(data_for_state$Hospital.Name[ordered_data_for_state[1]])
    } else if (num == "worst") {
        as.character(data_for_state$Hospital.Name[ordered_data_for_state[length(ordered_data_for_state)]])
    } else if (is.numeric(num)) {
        as.character(data_for_state$Hospital.Name[ordered_data_for_state[num]])
    } else {
        stop("invalid num")
    }
}