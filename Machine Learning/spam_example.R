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
