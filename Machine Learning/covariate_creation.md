---
title: "Covariate Creation"
author: "Christopher Lovell"
date: "Sunday, October 26, 2014"
output: pdf_document
---


## Introduction
There are two levels of covariate creation: transforming raw data in to a covariate, and transforming tidy covariates in to alternative forms.

### Raw Data -> Covariates
The balancing act is summarisation vs. information loss. More knowledge of a system you have the better the job you will do. Whn in doubt, err on the side of more features.

Feature selection can be automated, but should be done with caution.

### Tidy Covariates -> new covariates
Features you've already created on the dataset, transformed to make them more useful. 

The original building of the covariates should only be performed on the training set (otherwise you're at risk of overfitting).

## Example
First load the libraries and data, then split the Wage dataset in to training and testing sets.

```{r}
library(ISLR)
library(caret)
data(Wage)

inTrain <- createDataPartition(y=Wage$wage,p=0.7,list=FALSE)

training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
```

If we take a look at the jobclass variable, it is split in to Industrial and Information classes:
```{r}
table(training$jobclass)
```

These are factor, or qualitative, variables, and a machine learning algorithm may find them difficult to interpret in their extended current form, therefore we may wish to convert them to quantitative, or indicator, variables:

```{r}
dummies <- dummyVars(wage ~ jobclass,data=training)
head(predict(dummies,newdata=training))
```

### Removing Zero Covariates
If a covariate is almost always true, for example 'Does the email contain characters?', you can remove it using the following:

```{r}
nsv <- nearZeroVar(training,saveMetric=TRUE)
nsv
```

The sex variable is all Male, therefore it has no variability and can be thrown out. The same applies to the Region variable.

### Spline basis
Basis functions allow non-linear regression fitting. they are contained in the _splines_ package.

```{r}
library(splines)
bsBasis <- bs(training$age,df=3)
tail(bsBasis)
```

This function allows fitting of a third degree polynomial to the age data in the training set. It produces a dataframe with 3 columns, containing the original age data, age squared and age cubed.

### Fitting curves with splines
You can then pass this _bsBasis_ object to a linear fitting function against another variable in your training set, in this case wage. The plot shows the relationship between age and wage, along with a third order polynomial fit for the relationship.

```{r}
lm1 <- lm(wage ~ bsBasis,data=training)
plot(training$age,training$wage,pch=19,cex=0.5)
points(training$age,predict(lm1,newdata=training),col="red",pch=19,cex=0.5)
```

### Splines on the test set
Must create coivariates on the test set using the exact same procedure as the training.

```{r}
head(predict(bsBasis,age=testing$age))
```
