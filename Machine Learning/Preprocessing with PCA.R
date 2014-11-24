## Preprocessing with PCA
##

if(!require(caret)){
  install.packages("caret")
}
if(!require(kernlab)){
  install.packages("kernlab")
}

data(spam)

inTrain <- createDataPartition(y=spam$type,p=0.75,list=F)

training<-spam[inTrain,]
testing<-spam[-inTrain,]

# leave out 58th column (the outcome), calculate correlations, and return absolute var
M<-abs(cor(training[,-58]))
# remove correlations of variables with tyhemselves
diag(M)<-0
# which variables have a correlation greater than .8?
which(M>0.8,arr.ind=T)

names(spam)[c(34,32)]
plot(spam[,34],spam[,32])

# how can we combine these but retain as much information as possible?
# we could rotate the plot:
X <- 0.71*training$num415 + 0.71*training$num857
Y <- 0.71*training$num415 - 0.71*training$num857
plot(X,Y)
# adding the variables caches most of the info (most are constantat 0 on Y axis)

smallSpam <- spam[,c(34,32)]
prComp <- prcomp(smallSpam)
?prcomp
plot(prComp$x[,1],prComp$x[,2])

# equal to values shown before
prComp$rotation

# do for more vaiables...
# first assign color depending on type
typeColor <- ((spam$type=="spam")*1 + 1)
# apply log to make the data look more gaussian (often necessary for PCA)
prComp <- prcomp(log10(spam[,-58]+1))
plot(prComp$x[,1],prComp$x[,2],col=typeColor,xlab="PC1",ylab="PC2")

prComp$rotation


# can do the same with the Caret package using the preProcess function
preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
spamPC <- predict(preProc,log10(spam[,-58]+1))
plot(spamPC[,1],spamPC[,2],col=typeColor)


preProc <- preProcess(log10(spam[,-58]+1),method="pca",pcaComp=2)
trainPC <- predict(preProc,log10(training[,-58]+1))
# train model using PCs
modelFit <- train(training$type ~ .,method="glm",data=trainPC)

# pass preProc calculated on training data to test
testPC <- predict(preProc,log10(testing[,-58]+1))
confusionMatrix(testing$type,predict(modelFit,testPC))


# can also combine predict into training exercise:
modelFit <- train(training$type ~ .,method="glm",preProcess="pca",data=training)
confusionMatrix(testing$type,predict(modelFit,testing))





