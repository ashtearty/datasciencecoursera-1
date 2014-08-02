# Write a function that takes a directory of data files and a threshold for 
# complete cases and calculates the correlation between sulfate and nitrate 
# for monitor locations where the number of completely observed cases 
# (on all variables) is greater than the threshold. The function should 
# return a vector of correlations for the monitors that meet the threshold 
# requirement. If no monitors meet the threshold requirement, then the 
# function should return a numeric vector of length 0. A prototype of this 
# function follows

# 'directory' is a character vector of length 1 indicating
# the location of the CSV files

# 'threshold' is a numeric vector of length 1 indicating the
# number of completely observed observations (on all
# variables) required to compute the correlation between
# nitrate and sulfate; the default is 0

# Return a numeric vector of correlations

source("complete.R")

corr <- function (directory, threshold = 0)
{
    data_frame <- complete(directory)
    data_filter_threshold <- which(data_frame$nobs>threshold)
    full_file_list <- list.files(directory, full.names=TRUE)
    
    correlation <- c()
    increment <- 1
    
    if (length(data_filter_threshold) == 0)
    {
        correlation
    }
    for (iterator in data_filter_threshold)
    {
        data_for_corr_all <- read.csv(full_file_list[iterator])
        data_for_corr <- na.omit(data_for_corr_all)
        correlation[increment] <- cor(data_for_corr[,2],data_for_corr[,3])
        increment <- increment + 1        
    }
    correlation
}



cr <- corr("specdata", 150)
head(cr)
summary(cr)

cr <- corr("specdata", 400)
head(cr)
summary(cr)

cr <- corr("specdata", 5000)
summary(cr)
length(cr)

cr <- corr("specdata")
summary(cr)
length(cr)