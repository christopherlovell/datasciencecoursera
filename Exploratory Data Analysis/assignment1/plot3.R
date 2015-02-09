library(ggplot2)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "data//household_power_consumption.zip")
unzip("data//household_power_consumption.zip",exdir = "data")

data<-read.csv("data//household_power_consumption.txt",colClasses = c('character', 'character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric'),sep = ";",na.strings='?')


data$DateTime <- paste(data$Date,data$Time,sep = " ")

data$DateTime <- strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")

data <- subset(data,DateTime > as.POSIXct("2007/02/01 00:00:00") & DateTime < as.POSIXct("2007/02/03 00:00:00"))

png(filename = "plot3.png",width = 480,height = 480)
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright",lwd=2,col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
