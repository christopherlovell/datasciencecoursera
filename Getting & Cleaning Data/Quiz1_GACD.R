
# 17/4/2014

library(data.table)
library(xlsx)

# ----------
# QUESTION 1

# get and store data
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileurl,destfile=".\\data\\2006_housing_Idaho.csv")
dateDownloaded <- date()

housingdata <- read.table(".\\data\\2006_housing_Idaho.csv",sep=",",header=TRUE)
head(housingdata)

housingdata[,.N, by=housingdata$VAL]

#housingdata <- data.table(housingdata)

# ----------
# QUESTION 2

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile=".\\data\\natural_gas.xlsx")
dateDownloaded <- date()

gasdata <- read.xlsx(".\\data\\natural_gas.xlsx",sheetIndex=1,rowIndex=18:23,colIndex=7:15,header=TRUE)
                     
gasdata
dat <- gasdata

sum(dat$Zip*dat$Ext,na.rm=T) 

# ----------
# QUESTION 3

library(XML)

fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileURL,useInternal=TRUE)

rootnode <- xmlRoot(doc)

zipcodes <- xpathSApply(rootnode,"//zipcode",xmlValue)
sum(zipcodes=='21231')


# ----------
# QUESTION 5

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileurl,destfile=".\\data\\2006_housing_Idaho_B.csv")
dateDownloaded <- date()

DT <- fread(".\\data\\2006_housing_Idaho_B.csv")

# doesn't return correct answer
system.time(mean(DT$pwgtp15,by=DT$SEX))

# doesn't return at all
a <- system.time(rowMeans(DT)[DT$SEX==1])
b <- system.time(rowMeans(DT)[DT$SEX==2])
c <- a + b

# 0 
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

# 0
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

# 0.10
a <- system.time(mean(DT[DT$SEX==1,]$pwgtp15))
b <- system.time(mean(DT[DT$SEX==2,]$pwgtp15))
c <- a + b
c

# 0
system.time(DT[,mean(pwgtp15),by=SEX])

help(system.time)

# benchmark , or rbenchmark

require(stats)





