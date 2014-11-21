####
#### PLOTTING PREDICTORS
####

library(ISLR)
library(ggplot2)
if(!require(minqa)){
  install.packages("minqa")
}
if(!require(caret)){
  install.packages("caret")
}
if(!require(gridExtra)){
  install.packages("gridExtra")
}
if(!require(Hmisc)){
  install.packages("Hmisc")
}
if(!require(splines)){
  install.packages("splines")
}

data(Wage)
summary(Wage)

inTrain <- createDataPartition(y=Wage$wage,p=0.7,list=FALSE)

training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

dim(training)
dim(testing)

# feature plot

featurePlot(x=training[,c("age","education","jobclass")],
            y=training$wage,
            plot="pairs")
# can see a trend between education and salary

qplot(age,wage,data=training)
# chunk of observations with high wages, separate from the bulk

qplot(age,wage,colour=jobclass,data=training)
# see most of higher chunk observations are information jobs

# add regression smoothers
qq <- qplot(age,wage,colour=education,data=training)
qq + geom_smooth(method='lm',formula=y~x)
# separates education classes, and fits a linear model
# different relationships for age visible 


# making factors
cutwage <- cut2(training$wage,g=3)
table(cutwage)
# splits wages in to factors dependent on quantile groups

# boxplots using factors
p1 <- qplot(cutwage,age,data=training,fill=cutwage,
            geom=c("boxplot"))
p1
# shows a clearer trend with age

# boxplots with points overlayed
p2 <- qplot(cutwage,age,data=training,fill=cutwage,
            geom=c("boxplot","jitter"))
grid.arrange(p1,p2,ncol=2)
# grid arrange arranges the two plots
# lots of plots visible, therefore the trend could be real
# if there were less points in one of the boxes this might suggest a spurious relationship

# view tables
t1 <- table(cutwage,training$jobclass)
t1

# get proportions in each group
prop.table(t1,1)
            
# density plots
qplot(wage,colour=education,data=training,geom="density")
# shows where the bulk of the data is
# also identifies the outgroup
# easier to overlay multiple plots with this method

###
### COVARIATE CREATION
###

table(training$jobclass)
# create dummy vars for jobclass that avoid text based division
dummies<-dummyVars(wage ~ jobclass,data=training)
head(predict(dummies,newdata=training))

# removing zero covariates
nsv<-nearZeroVar(training,saveMetrics=T)
nsv
# can see the percentage of unique values for a particular variable
# freqRatio shows number of categories
# tells you which predictors to throw out right away

# fit polynomial regression
# df specifies degree
bsBasis<- bs(training$age,df=3)
bsBasis

# fit curve with 'splines' package
lm1<-lm(wage ~ bsBasis,data=training)
plot(training$age,training$wage,pch=19,cex=0.5)
points(training$age,predict(lm1,newdata=training),col="red",pch=19,cex=0.5)

# apply to test set using predictors(?) from training
predict(bsBasis,age=testing$age)





