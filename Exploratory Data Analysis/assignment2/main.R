
library(plyr)
library(ggplot2)
library(gridExtra)

wd<-"C://Users//Chris//Documents//Data Science Files//datasciencecoursera//Exploratory Data Analysis//assignment2"
setwd(wd)

library(plyr)
library(ggplot2)
library(gridExtra)

file.zip<-download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="FNEI_data.zip")

unzip(zipfile = "FNEI_data.zip")

classification.code<-readRDS(file = "Source_Classification_Code.rds")
scc.pm25<-readRDS("summarySCC_PM25.rds")


## Plot 1
png(filename = "question1.png",width = 480,height = 480)
year.sum<-ddply(scc.pm25,"year",numcolwise(sum))
plot(year.sum,type = 'l',main="PM-2.5 emissions in the US, \n1999-2008")
dev.off()

## Plot 2
png(filename = "question2.png",width = 480,height = 480)
scc.pm25.baltimore_city<-subset(scc.pm25,fips=="24510")
year.sum<-ddply(scc.pm25.baltimore_city,"year",numcolwise(sum))
plot(year.sum,type = 'l',main="PM-2.5 emissions in Baltimore City, Maryland, \n1999-2008")
dev.off()

## Plot 3
png(filename = "question3.png",width = 480,height = 480)
scc.pm25.baltimore_city<-subset(scc.pm25,fips=="24510")
year.sum<-ddply(scc.pm25.baltimore_city,.variables = c("year","type"),numcolwise(sum))
p1<-ggplot(data=year.sum,aes(x=year,y=Emissions,fill=type,colour=type))
p1<-p1+geom_line(stat="identity")
p1<-p1+ggtitle("PM-2.5 sources in Baltimore City, Maryland, \n1999-2008")
p1
dev.off()

## Plot 4
png(filename = "question4.png",width = 480,height = 480)
coal_sources<-c("Fuel Comb - Comm/Institutional - Coal"
                ,"Fuel Comb - Industrial Boilers, ICEs - Coal "
                ,"Fuel Comb - Comm/Institutional - Coal")
classification.code.coal<-subset(classification.code,classification.code$EI.Sector %in% coal_sources)

scc.pm25.coal<-scc.pm25[scc.pm25$SCC %in% classification.code.coal$SCC,]

year.sum<-ddply(scc.pm25.coal,.variables = c("year","type"),numcolwise(sum))

p1<-ggplot(data=year.sum,aes(x=year,y=Emissions,fill=type,colour=type))
p1<-p1+geom_area(position = 'stack')
p1<-p1+ggtitle("PM-2.5 emissions from \ncoal combustion-related sources,\n 1999-2008")
p1

dev.off()

## Plot 5
png(filename = "question5.png",width = 480,height = 480)
motor_vehicle_sources<-c("Mobile - On-Road Gasoline Light Duty Vehicles"
                         ,"Mobile - On-Road Gasoline Heavy Duty Vehicles"
                         ,"Mobile - On-Road Diesel Light Duty Vehicles"
                         ,"Mobile - On-Road Diesel Heavy Duty Vehicles")
classification.code.motor<-subset(classification.code,classification.code$EI.Sector %in% motor_vehicle_sources)
scc.pm25.baltimore_city.motor<-subset(scc.pm25,fips=="24510" & SCC %in% classification.code.motor$SCC)

year.sum<-ddply(scc.pm25.baltimore_city.motor,.variables = "year",numcolwise(sum))
p1<-ggplot(data=year.sum,aes(x=year,y=Emissions))+geom_line(stat="identity")
p1<-p1+ggtitle("PM-2.5 emissions from motor vehicle sources\n in Baltimore City, Maryland, 1999-2008")
p1

dev.off()

## Plot 6
png(filename = "question6.png",width = 480,height = 480)
motor_vehicle_sources<-c("Mobile - On-Road Gasoline Light Duty Vehicles"
                         ,"Mobile - On-Road Gasoline Heavy Duty Vehicles"
                         ,"Mobile - On-Road Diesel Light Duty Vehicles"
                         ,"Mobile - On-Road Diesel Heavy Duty Vehicles")
classification.code.motor<-subset(classification.code,classification.code$EI.Sector %in% motor_vehicle_sources)

scc.pm25.motor<-subset(scc.pm25,fips %in% c("06037","24510") & SCC %in% classification.code.motor$SCC)

year.sum<-ddply(scc.pm25.motor,.variables = c("fips","year"),numcolwise(sum))

year.sum[year.sum$fips=="06037","index"]<-apply(year.sum[year.sum$fips=="06037",],1,function(x) as.numeric(x[3])/year.sum[year.sum$year=="1999" & year.sum$fips=="06037",3])
year.sum[year.sum$fips=="24510","index"]<-apply(year.sum[year.sum$fips=="24510",],1,function(x) as.numeric(x[3])/year.sum[year.sum$year=="1999" & year.sum$fips=="24510",3])

p1<-ggplot(data=year.sum,aes(x=year,y=index,fill=fips,colour=fips))
p1<-p1+geom_line(stat="identity")
p1<-p1+scale_colour_discrete(name="County",
                           breaks=c("06037", "24510"),
                           labels=c("Los Angeles County","Baltimore City"))

p2<-ggplot(data=year.sum,aes(x=year,y=Emissions,fill=fips,colour=fips))+geom_line(stat="identity")
p2<-p2+scale_colour_discrete(name="County",
                             breaks=c("06037", "24510"),
                             labels=c("Los Angeles County","Baltimore City"))

grid.arrange(p2,p1)

dev.off()
