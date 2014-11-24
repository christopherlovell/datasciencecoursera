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
X<- 0.71*training$num415 + 0.71*training$num857
Y<- 0.71*training$num415 - 0.71*training$num857
plot(X,Y)





