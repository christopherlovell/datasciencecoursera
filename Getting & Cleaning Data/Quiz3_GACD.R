# Getting and Cleaning Data - Quiz 3


# ------------
# Q2 ---------
# ------------

library(jpeg)
image<-readJPEG(".//data/getdata-jeff.jpg",native=TRUE)
quantile(image,c(0.3,0.8))

# ------------
# Q3 ---------
# ------------

library(plyr)

ED_Data <- read.csv(".//data//getdata-data-EDSTATS_Country.csv",sep=",",header=TRUE)
GDP_Data <- read.csv(".//data//getdata-data-GDP.csv",sep=",",skip=5,header=FALSE)

# remove annoying text
GDP_Data<-GDP_Data[-c(233,234,235,236),]

# remove unnecessary columns
GDP_Data<-GDP_Data[,c("V1","V2","V4","V5")]

#remove empty rows from CountryCode and number (so that only countries returned)
GDP_Data<-GDP_Data[-which(GDP_Data$V2==""),]

# convert non numeric characters (remove commas)
GDP_Data$V5<-as.numeric(gsub(",","",GDP_Data$V5))

# rename column
GDP_Data<-rename(GDP_Data,replace=c("V1"="CountryCode"))

# merge tables together
m1<-join(ED_Data,GDP_Data,by="CountryCode",type="inner")

# number of matching IDs
nrow(m1)

# ordered list (by GDP)
m2<-m1[with(m1,order(V5,decreasing=FALSE)),]

head(m2,13)

# ------------
# Q4 ---------
# ------------

# filter results
filt_high<-m2[m2$Income.Group=="High income: OECD",]

# convert to numeric then calculate mean
mean(as.numeric(as.character(droplevels(filt_high$V2))))

# filter results
filt_high<-m2[m2$Income.Group=="High income: nonOECD",]

# convert to numeric then calculate mean
mean(as.numeric(as.character(droplevels(filt_high$V2))))

# ------------
# Q5 ---------
# ------------

library(Hmisc)

#split in to equal groups
m2$quantile <- with(m2, cut2(V5,g=5,levels.mean=TRUE))

#subset data
m3<-m2[c("Income.Group","quantile")]

#
topm3<-head(m3,n=38)
sum(topm3$Income.Group == "Lower middle income")







