# Write a function that reads a directory full of files and reports 
# the number of completely observed cases in each data file. The function 
# should return a data frame where the first column is the name of the file 
# and the second column is the number of complete cases. A prototype of this 
# function follows

# 'directory' is a character vector of length 1 indicating
# the location of the CSV files
# 
# 'id' is an integer vector indicating the monitor ID numbers
# to be used
# 
# Return a data frame of the form:
# id nobs
# 1  117
# 2  1041
# ...
# where 'id' is the monitor ID number and 'nobs' is the
# number of complete cases

complete <- function(directory, id = 1:332) {
    files_complete <- list.files(directory, full.names = TRUE)
    file_c_list <- c(id)
    file_value_list <- c()
    increment <- 1
    for (file in id)
    {
        
        place_holder <- read.csv(files_complete[file])
        file_value_list[increment] <- nrow(na.omit(place_holder))
        increment <- increment + 1 
    }
    data_with_info <- data.frame(id = file_c_list, nobs = file_value_list)
    data_with_info
}

# Unit Test
# complete("specdata", 1)
# complete("specdata", 1:10)
# complete("specdata", c(2, 4, 8, 10, 12))
# complete("specdata", 30:25)
# complete("specdata", 3)




complete <- function(directory, id = 1:332){
    ## 'director' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the from:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    results <- data.frame(id=numeric(0), nobs=numeric(0))
    for(monitor in id){
        path <- paste(getwd(), "/", directory, "/", sprintf("%03d", monitor), ".csv", sep = "")
        monitor_data <- read.csv(path)
        interested_data <- monitor_data[(!is.na(monitor_data$sulfate)), ]
        interested_data <- interested_data[(!is.na(interested_data$nitrate)), ]
        nobs <- nrow(interested_data)
        results <- rbind(results, data.frame(id=monitor, nobs=nobs))
    }
    results
}
