data_from_file <- read.table("data.txt")
data_from_file

data_file_csv <- read.csv("specdata/055.csv")
data_file_csv

y <- data.frame(data_file_csv)
dput(y, file = "updated_data_file_csv.R")

new.y <- dget("updated_data_file_csv.R")
new.y

dump(c("data_from_file","data_file_csv","y","new.y"), file = "data.R")
source("data.R")

data_from_file
data_file_csv
y
new.y