
wd<-"C://Users//Chris//Documents//Data Science Files//datasciencecoursera//Exploratory Data Analysis//assignment2"
setwd(wd)

file.zip<-download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="FNEI_data.zip")

unzip(zipfile = "FNEI_data.zip")
