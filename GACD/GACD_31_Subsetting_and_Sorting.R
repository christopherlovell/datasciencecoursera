set.seed(13435)

X <- data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
X <- X[sample(1:5),]
X$var2[c(1,3)]=NA
X

# show first column values
X[,1]
X[,"var1"]

# show first 2 rows of first column values
X[1:2,"var1"]

# show first 2 rows of second column values
X[1:2,"var2"]

# AND
X[(X$var1<=3 & X$var3 > 11),]

# OR
X[(X$var1<=3 | X$var3 > 11),]

# conditional, but shows all rows
X[which(X$var2 > 8),]

# sort the data frame on the first column (with decreasing tag set)
sort(X$var1,decreasing=TRUE)

# sort, but shows all rows
X[order(X$var1),]

# sort on two columns (first variable 
# first, then second variable on the first)
X[order(X$var1,X$var3),]

# plyr
library(plyr)

# sort on variable 1
arrange(X,var1)
arrange(X,desc(var1))

#adding rows and columns to data frames is simple
X$var4 <- rnorm(5)  # add random normal variable to column
X

# can also use column bind..
Y <- cbind(X,rnorm(5)) # binds to the right side of X
Y

# similar functionality with rbind



