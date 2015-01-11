---
title: "Reproducible Research: Peer Assessment 1"
output: 
  html_document:
    keep_md: true
---


## Loading and preprocessing the data




Read CSV activity file from unzipped directory.

```r
activity <- read.csv("activity/activity.csv")
```

Convert *date* variable to date format. Create *time* variable based on *interval* where interval is converted to time, but over a single day (date code run).  

```r
activity$date <- as.Date(as.character(activity$date),format="%Y-%m-%d")

activity$time <- formatC(activity$interval/100, 2, format = "f")
activity$time <- as.POSIXct(activity$time,format="%H.%M")
```

## What is mean total number of steps taken per day?

First we look at the steps taken each day by calculating a *daily steps* varibable. Below is a plot of total steps per day over the period of observation. NA values are removed.

```r
daily_steps <- tapply(activity$steps, activity$date, sum, na.rm = TRUE)

barplot(daily_steps,xlab="Date",ylab="Step Count",main="Steps per Day")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 

Using the *daily_steps* variable we plot a histogram of daily frequency counts, broken down in to 15 equal sized step bins.

```r
hist(daily_steps,breaks=15,xlab="Daily Steps",ylab="Frequency (Day)",main="Histogram of daily steps")
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

Per day, the mean number of steps  is 9354 and the median is 10395.

## What is the average daily activity pattern?

First calculate the mean steps per interval of time over all dates. Then use this to construct a data frame with two columns, one with the mean steps, the other with the time obtained from the names of the *mean_steps* variable. The plot shows the mean over all intervals sequentially.


```r
mean_steps <- tapply(activity$steps, activity$time, mean, na.rm=TRUE)
step_frame <- data.frame(steps=mean_steps,time=as.POSIXct(names(mean_steps)))

ggplot(step_frame,aes(time,steps))+geom_line()+scale_x_datetime(labels = date_format(format="%H:%M")) + xlab("Time") + ylab("Mean no. of steps") + ggtitle("Mean steps against time interval")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

Which 5-minute interval, on average across all the days in the dataset, contains the maximum number of steps?


```r
format(as.POSIXct(names(which.max(step_frame$steps))),format="%H:%M")
```

```
## [1] "08:35"
```

## Imputing missing values

Number of NAs in the data file?


```r
isNA<-table(is.na(activity$steps))
isNA[2][[1]]
```

```
## [1] 2304
```

We wish to replace these missing values with something more meaningful. In this example we use the mean for that 5 minute period over existing data. 

The means for these time periods are stored in the *step_frames* data frame:

```r
head(step_frame[1])
```

```
##                         steps
## 2014-12-07 00:00:00 1.7169811
## 2014-12-07 00:05:00 0.3396226
## 2014-12-07 00:10:00 0.1320755
## 2014-12-07 00:15:00 0.1509434
## 2014-12-07 00:20:00 0.0754717
## 2014-12-07 00:25:00 2.0943396
```

To carry out the replacement we first replicate the *activity* variable in to *activity_fill*. We then apply a function that checks for NAs, and replaces them with the mean for the corresponding time interval.


```r
activity_fill <- activity

activity_fill$steps<-apply(activity_fill,1,
                function(x) 
                  if(is.na(x[1])){ 
                    x[1]<-as.numeric(step_frame[step_frame$time==x[4],1])
                  }
                  else{x[1]}
                )

activity_fill$steps <- as.numeric(activity_fill$steps)
```

... resulting in no more NAs!


```r
head(activity_fill)
```

```
##       steps       date interval                time
## 1 1.7169811 2012-10-01        0 2014-12-07 00:00:00
## 2 0.3396226 2012-10-01        5 2014-12-07 00:05:00
## 3 0.1320755 2012-10-01       10 2014-12-07 00:10:00
## 4 0.1509434 2012-10-01       15 2014-12-07 00:15:00
## 5 0.0754717 2012-10-01       20 2014-12-07 00:20:00
## 6 2.0943396 2012-10-01       25 2014-12-07 00:25:00
```

We can then recalculate the number of steps per day, here assigned to *daily_steps_fill*, inclusive of the filled data points. The new histogram of total steps per day, broken down in to 15 equal sized step bins is shown below:


```r
daily_steps_fill <- tapply(activity_fill$steps, activity_fill$date, sum, na.rm = TRUE)
hist(daily_steps_fill,breaks=15,xlab="Daily Steps",ylab="Frequency (Day)",main="Histogram of daily steps (with filled values)")
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png) 

The lowest step count frequency bin has now drastically reduced, and there is a single peak in the distribution at ~10000 steps.

Per day, the mean number of steps  is 10766 as compared to 9354 with NAs, and the median is 10766 as compared to 10395 with NAs.



## Are there differences in activity patterns between weekdays and weekends?

For this part we will continue to use the data set with missing values filled in, *activity_fill*.

We are going to create a factor variable indicating whether a day is on the weekend or during the week, first calculating the weekday from the date using the *weekdays* function. We then string match for "Saturday" & "Sunday" to create the weekend boolean.


```r
activity_fill$day<-weekdays(activity_fill$date)
activity_fill$weekend<-sapply(activity_fill$day,function(x) if(x %in% c("Saturday","Sunday")){T}else{F})
```

We wish to compare step counts on weekends anfd weekdays. To do this we follow the same proces as previously in calculating the mean steps for each time interval, but in this case we do so for both sets independently, using the *interaction* function.


```r
mean_steps_fill <- tapply(activity_fill$steps, interaction(activity_fill$time,activity_fill$weekend), mean)
```

We then create a data frame, with *weekend* set as a factor variable, and plot the interval sequentially for both sets using *facet_grid*.



```r
step_frame_fill <- data.frame(steps=mean_steps_fill,time=as.POSIXct(names(mean_steps_fill)),weekend=as.factor(c(rep("weekday", 288), rep("weekend", 288))))

ggplot(step_frame_fill,aes(time,steps))+geom_line()+scale_x_datetime(labels = date_format(format="%H:%M")) + xlab("Time") + ylab("Mean no. of steps") + ggtitle("Mean steps against time interval") + facet_grid(. ~ weekend)
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15-1.png) 



