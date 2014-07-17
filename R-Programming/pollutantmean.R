# Write a function named 'pollutantmean' that calculates 
# the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', 
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads 
# that monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all of the 
# monitors, ignoring any missing values coded as NA. A prototype of the function 
# is as follows

# 'directory' is a character vector of length 1 indicating
# the location of the CSV files
# 
# 'pollutant' is a character vector of length 1 indicating
# the name of the pollutant for which we will calculate the
# mean; either "sulfate" or "nitrate".
# 
# 'id' is an integer vector indicating the monitor ID numbers
# to be used
# 
# Return the mean of the pollutant across all monitors list
# in the 'id' vector (ignoring NA values)

pollutantmean <- function(directory, pollutant, id = 1:332) {
    files <- list.files(directory, full.names=TRUE)
    dat <- data.frame()
    
    for(i in id)
    {
        dat <- rbind(dat, read.csv(files[i]))
    }
    
    mean_data <- mean(dat[,pollutant], na.rm = TRUE)
    round(mean_data, digits=3)
}

# Unit Test
# pollutantmean("specdata", "sulfate", 1:10)
# pollutantmean("specdata", "nitrate", 70:72)
# pollutantmean("specdata", "nitrate", 23)