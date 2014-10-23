# R programming - Quiz 3


# Q1 ---------

library(datasets)
data(iris)

x <- subset(iris,Species=='virginica')
mean(x$Sepal.Length)

# Q2 ---------

apply(iris[,1:4],2,mean)

# Q3 ---------

library(datasets)
data(mtcars)

with(mtcars, tapply(mpg, cyl, mean))

# Q4 ---------

c4 <- mean(subset(mtcars,cyl=='4')$hp)
c8 <- mean(subset(mtcars,cyl=='8')$hp)





