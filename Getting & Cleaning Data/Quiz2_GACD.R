
fileurl <- "http://biostat.jhsph.edu/~jleek/contact.html"

download.file(fileurl,destfile=".\\data\\biostat.csv")

biodata <- read.table(".\\data\\biostat.csv",sep="\n",header=FALSE)

biodata[9,]

demo <- "  			<ul class=\"sidemenu\">"

#nchar(as.character(biodata[9,]))

nchar(demo)

# ----------
# QUESTION 5

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"

download.file(fileurl,destfile=".\\data\\for.csv")

fordata <- read.fortran(".\\data\\for.csv",c("Week","SST","SSTA","SST","SSTA","SST","SSTA","SST","SSTA"),skip="4")

help(read.fortran)

fordata

head(fordata)
