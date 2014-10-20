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


