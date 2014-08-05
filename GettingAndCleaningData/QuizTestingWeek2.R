library("RMySQL")
ucscDb <- dbConnect(MySQL(), user="genome", db="hg19",
                    host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(ucscDb)
length(allTables)
dbDisconnect(ucscDb)

allTables[1:5]

