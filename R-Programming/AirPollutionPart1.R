## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "slulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)

## data_file_csv <- read.csv(file_path)


get_file_name_from_id <- function (id)
{
    if (id < 10)
    {
        file_name <- paste("00", id, ".csv", sep="")
        file_name <- as.character(file_name)
    }
    else if (id < 100 && id > 9)
    {
        file_name <- paste("0", id, ".csv", sep="")
        file_name <- as.character(file_name)
    }
    else
    {
        file_name <- paste(id, ".csv", sep="")
        file_name <- as.character(file_name)
    }
    
    file_name
}

pollutantmean <- function(directory, pollutant, id = 1:332) 
{
    
    data_mean_pollutant <- NULL
    if(pollutant == "sulfate")
    {
        column <- 2
    }
    else
    {
        column <- 3
    }
    
    
    for (file_in_list in id)
    {
        file_name <- get_file_name_from_id(file_in_list)
        file_path <- paste(directory, "/", file_name, sep="") 
        
#         print(file_in_list)
#         print(file_name)
#         print(file_path)
        
        data_for_processing <- read.csv(file_path)        
        data_mean_pollutant[file_in_list] <- mean(data_for_processing[,column], na.rm = TRUE)
        
    }
    
    print(data_mean_pollutant)
    print(mean(data_mean_pollutant, na.rm = TRUE ))

}

pollutantmean("specdata", "nitrate", 70:72)
