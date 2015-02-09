library(ggplot2)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "data//household_power_consumption.zip")
unzip("data//household_power_consumption.zip",exdir = "data")

data<-read.csv("data//household_power_consumption.txt",colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'),sep = ";",na.strings='?')

data$DateTime <- paste(data$Date,data$Time,sep = " ")

data$DateTime <- strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")

data <- subset(data,DateTime > as.POSIXct("2007/02/01 00:00:00") & DateTime < as.POSIXct("2007/02/03 00:00:00"))

png(filename = "plot1.png",width = 480,height = 480)
hist(data$Global_active_power,breaks = seq(0,8,by=0.5),col="red",freq = T,xlim = c(0,6),xlab="Global Active Power (kilowatts)",main="Global Active Power",xaxt = 'n')
axis(side=1, at=seq(0,6,2), labels=seq(0,6,2))
dev.off()
