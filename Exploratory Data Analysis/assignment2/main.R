
library(plyr)
library(ggplot2)

wd<-"C://Users//Chris//Documents//Data Science Files//datasciencecoursera//Exploratory Data Analysis//assignment2"
setwd(wd)

file.zip<-download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",destfile="FNEI_data.zip")

unzip(zipfile = "FNEI_data.zip")

classification.code<-readRDS(file = "Source_Classification_Code.rds")
scc.pm25<-readRDS("summarySCC_PM25.rds")


## Plot 1
year.sum<-ddply(scc.pm25,"year",numcolwise(sum))
plot(year.sum,type = 'l')

## Plot 2
scc.pm25.baltimore_city<-subset(scc.pm25,fips=="24510")
year.sum<-ddply(scc.pm25.baltimore_city,"year",numcolwise(sum))
plot(year.sum,type = 'p')

## Plot 3
scc.pm25.baltimore_city<-subset(scc.pm25,fips=="24510")
year.sum<-ddply(scc.pm25.baltimore_city,.variables = c("year","type"),numcolwise(sum))
p1<-ggplot(data=year.sum,aes(x=year,y=Emissions,fill=type,colour=type))+geom_line(stat="identity")
p1

## Plot 4
classification.code.coal<-subset(classification.code,classification.code$EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal ","Fuel Comb - Comm/Institutional - Coal"))
scc.pm25.coal<-scc.pm25[scc.pm25$SCC %in% classification.code.coal$SCC,]

year.sum<-ddply(scc.pm25.coal,.variables = c("SCC","year"),numcolwise(sum))
year.sum.total<-ddply(scc.pm25.coal,.variables = c("year"),numcolwise(sum))
year.sum.total<-cbind("Total",year.sum.total)
names(year.sum.total)<-names(year.sum)
year.sum<-rbind(year.sum,year.sum.total)

p1<-ggplot(data=year.sum,aes(x=year,y=Emissions,fill=SCC,colour=SCC))+geom_line(stat="identity")
p1

## Plot 5
classification.code.coal<-subset(classification.code,classification.code$EI.Sector == "Fuel Comb - Comm/Institutional - Coal")






