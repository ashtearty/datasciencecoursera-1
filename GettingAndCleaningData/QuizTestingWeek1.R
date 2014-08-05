#urlInfo = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
#download.file(urlInfo, destfile = 'housing.csv', method = 'curl')

data <- read.csv('housing.csv',header = TRUE)
head(data)

library(data.table)
DT <- data.frame(data)
X <- as.numeric(DT[,c(37)], na.exclude =TRUE)
Y <- X[!is.na(X)]
Y
Y[Y==24]

# xlsxUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# download.file(xlsxUrl, destfile = 'NGAP.xlsx', method = 'curl')

#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
library(xlsx)

col <- 7:15
rows <- 18:23

xlx <- read.xlsx("NGAP.xlsx", sheetIndex = 1, colIndex = col, rowIndex = rows)
xlx

sum(xlx$Zip*xlx$Ext,na.rm=T) 

xmlLink ="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(xmlLink, destfile = 'restaurants.xml', method = 'curl')

library(XML)

doc <- xmlTreeParse('restaurants.xml', useInternalNodes = TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
xmlSApply(rootNode, "21231")

listZips <- as.numeric(xpathSApply(rootNode, "//zipcode", xmlValue))
x <- listZips[listZips==21231]
length(x)
