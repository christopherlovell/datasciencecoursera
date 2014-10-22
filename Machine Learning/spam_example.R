library(caret)
library(kernlab)

data(spam)

inTrain <- createDataPartition(y=spam$type,p=0.75,list=FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

####

set.seed(334)

# ~. in the type part of the function call represents using all types in the data frame to train the model
# glm is one of many models
modelFit <- train(type ~.,data=training,method="glm")
modelFit


####

predictions <- predict(modelFit,newdata=testing)
predictions

####

confusionMatrix(predictions,testing$type)


####
#### TRAINING OPTIONS
####

# k-fold example

set.seed(32323)
folds <- createFolds(y=spam$type,k=10,list=TRUE,returnTrain=FALSE)

sapply(folds,length)

folds[[2]][1:10]

# Resampling example

folds <- createResample(y=spam$type,times=10,list=TRUE)

sapply(folds,length)

folds[[2]][1:10]

# Time slices example

tme <- 1:1000
folds<- createTimeSlices(y=tme,initialWindow=20,horizon=10)

names(folds)

folds$train[[2]]
folds$test[[2]]

args(train.default)
args(trainControl)

####
#### PLOTTING PREDICTORS
####

library(ISLR)
library(ggplot2)
library(caret)

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

library(Hmisc)
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
library(gridExtra)
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



