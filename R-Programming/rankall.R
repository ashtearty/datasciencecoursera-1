# source : https://github.com/Shekeen/Computing-For-Data-Analysis-Class/tree/master/ProgAssignment2-data

# 
# Ranking hospitals in all states
# 
# Write a function called rankall that takes two arguments: an outcome name (outcome) and a hospital rank-
#     ing (num). The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified in num. For example the function call
# rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
# are the best in their respective states for 30-day heart attack death rates. The function should return a value
# for every state (some may be NA). The first column in the data frame is named hospital, which contains
# the hospital name, and the second column is named state, which contains the 2-character abbreviation for
# the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
# hospitals when deciding the rankings.
#
# Handling ties. The rankall function should handle ties in the 30-day mortality rates in the same way
# that the rankhospital function handles ties.


rankall <- function(outcome, num = "best") {
    full_data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
    
    column <- if (outcome == "heart attack") {
        full_data[, 11] <- as.numeric(full_data[, 11])
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
    } else if (outcome == "heart failure") {
        full_data[, 17] <- as.numeric(full_data[, 17])
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
    } else if (outcome == "pneumonia") {
        full_data[, 23] <- as.numeric(full_data[, 23])
        "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    } else {
        stop("invalid outcome")
    }
    
    data_by_state <- split(full_data[, c("Hospital.Name", "State", column)], full_data$State)
    
    rank_hospital <- function(state_data, num) {
        ordered_state_data <- order(state_data[3], state_data$Hospital.Name, na.last=NA)
        
        if (num == "best") {
            state_data$Hospital.Name[ordered_state_data[1]]
        } else if (num == "worst") {
            state_data$Hospital.Name[ordered_state_data[length(ordered_state_data)]]
        } else if (is.numeric(num)) {
            state_data$Hospital.Name[ordered_state_data[num]]
        } else {
            stop("invalid num")
        }
    }
    
    pre_result <- lapply(data_by_state, rank_hospital, num)
    
    data.frame(hospital = unlist(pre_result), state = names(pre_result), row.names = names(pre_result))
}