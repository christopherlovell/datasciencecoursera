
getwd()
pollution <- read.csv("data\\daily_44201_2014\\daily_44201_2014.csv")#,colClasses=c("numeric","character","factor","numeric","numeric"))

head(pollution)

summary(pollution$Observation.Count)

boxplot(pollution$Arithmetic.Mean,col="blue")
abline(h=0.04)

hist(pollution$Arithmetic.Mean,col="green",breaks=100)
rug(pollution$Arithmetic.Mean)
abline(v=0.04,lwd=2)
abline(v=median(pollution$Arithmetic.Mean),col="magenta",lwd=4)

barplot(table(pollution$State.Name),col="wheat",main="states")

boxplot(pollution$Arithmetic.Mean ~ pollution$State.Name,col="blue")

par(mfrow=c(2,1),mar=c(4,4,2,1))
hist(subset(pollution,State.Name=="Maine")$Arithmetic.Mean,col="green",main="title")
hist(subset(pollution,State.Name=="Alabama")$Arithmetic.Mean,col="green",main="title")

sub_poll <- subset(pollution,State.Name == "Maine" | State.Name == "Alabama")
head(sub_poll)
tail(sub_poll)
with(sub_poll,plot(Latitude,Arithmetic.Mean,col=State.Name))


# Plotting systems
# ----------------

library(datasets)
data(cars)
with(cars,plot(speed,dist))

library(lattice)
state <- data.frame(state.x77,region=state.region)
xyplot(Life.Exp ~ Income | region, data = state, layout = c(4,1))

library(ggplot2)
data(mpg)
qplot(displ,hwy,data=mpg)


# Base plotting system in R
# -------------------------

library(datasets)
with(airquality,plot(Wind,Ozone))
title(main="Ozone and Wind in New York City")

# colour different points
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in New York City"))
with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))

# colour different points with subsets and add legend
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in New York City",type="n"))
with(subset(airquality,Month==5),points(Wind,Ozone,col="blue"))
with(subset(airquality,Month!=5),points(Wind,Ozone,col="red"))
legend("topright",pch=1,col=c("blue","red"),legend=c("May","Other Months"))

# add regression fit
with(airquality,plot(Wind,Ozone,main="Ozone and Wind in New York City",pch=20))
model<-lm(Ozone ~ Wind,airquality)
abline(model,lwd=2)

# plot more than one graph
par(mfrow=c(1,2))
with(airquality,{
  plot(Wind,Ozone,main="Ozone and Wind")
  plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
})

# make margins a little bigger to fit in overall title
par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,0))
with(airquality,{
  plot(Wind,Ozone,main="Ozone and Wind")
  plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
  plot(Temp,Ozone,main="Ozone and Temperature")
  mtext("Ozone and Weather in New York City",outer=TRUE)
})


# Creating file plots
# -------------------

pdf(file='myplot.pdf')
with(faithful,plot(eruptions,waiting))
title(main="OldFaithful Geyser Data")
dev.off() # close the pdf file device







