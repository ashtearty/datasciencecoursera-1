weightmedian <- function(directory, day) {
    files_list <- list.files(directory, full.names=TRUE)
    #creates a list of files
    dat <- data.frame()
    #creates an empty data frame
    for (i in 1:5) {
        #loops through the files, rbinding them together
        dat <- rbind(dat, read.csv(files_list[i]))
    }
    dat_subset <- dat[dat[, "Day"] == day,]
    #subsets the rows that match the 'day' argument
    median(dat_subset$Weight, na.rm=TRUE)
    #identifies the median of the subset
    #while stripping out the NAs
}

files <- list.files("specdata", full.names=TRUE)
dat <- data.frame()

for(i in 70:72)
{
    dat <- rbind(dat, read.csv(files[i]))
}

mean_data <- mean(dat[,3], na.rm = TRUE)
mean_data


data <- rbind(read.csv("specdata/070.csv"),read.csv("specdata/071.csv"),read.csv("specdata/072.csv"))
meandata <- mean(data[,3], na.rm = TRUE)
meandata

source("complete.R")
data_frame <- complete("specdata")
data_frame
data_filter_threshold <- data_frame$nobs>500
vector <- c()
for (item in 1:332)
{
    if(data_filter_threshold[item] == TRUE)
        vector <- c(vector, item)
    else
        next
}
print(vector)

