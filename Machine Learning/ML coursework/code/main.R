
## ML coursework

if(!require(e1071)){
  install.packages("e1071")
}
if(!require(caret)){
  install.packages("caret")
}
if(!require(kernlab)){
  install.packages("kernlab")
}
if(!require(ggplot2)){
  install.packages("ggplot2")
}
if(!require(Hmisc)){
  install.packages("Hmisc")
}
if(!require(gridExtra)){
  install.packages("gridExtra")
}


wd<-"C://Users//Chris//Documents//Data Science Files//datasciencecoursera//Machine Learning//ML coursework"
setwd(wd)

testing<-read.csv("input//pml-testing.csv")
training<-read.csv("input//pml-training.csv")

# summary stats on training data
summary(training)


# investigatory featurePlot
featurePlot(x=training[,c("accel_forearm_x",
                          "accel_forearm_y",
                          "accel_forearm_z")],
            y = training$magnet_belt_x,
            plot="pairs")

# quick qplot, with colour
qplot(roll_belt,yaw_belt,colour=classe,data=training)


# cut, and box plot
roll_belt_cut <- cut2(training$roll_belt,g=3)
table(roll_belt_cut)
p1<-qplot(roll_belt_cut,yaw_belt,data=training,fill=roll_belt_cut,geom=c("boxplot"))
p1

# add points overlayed
p2<-qplot(roll_belt_cut,yaw_belt,data=training,fill=roll_belt_cut,geom=c("boxplot","jitter"))
grid.arrange(p1,p2,ncol=2)
p2


# show realtive proportions
t1<-table(roll_belt_cut,training$new_window)
prop.table(t1,1)

# density plot
qplot(roll_belt,colour=new_window,data=training,geom="density")

# args(train.default)
# args(trainControl)

set.seed(1234)
modelFit <- train(classe ~.,
                data=training,
                method="glm")


