# Reproducible Research: Peer Assessment 1

```r
knitr::opts_chunk$set(echo = TRUE)
```


### Download the data

```r
# Download and unzip the file from assignment web page. Get in the right directory in R.
data<-read.csv("activity.csv")
```


```r
library(stats)
library(dplyr)
```
## Number of steps per day (ignoring missing values)

```r
par(mfrow=c(1,1))
stepsPerDay<-aggregate(data=data,FUN=sum,steps~date)
hist(stepsPerDay$steps,main="Histogram Steps per day",xlab = "Steps per day",col="red")
```

![](PA1_template_files/figure-html/stepsPerDay-1.png)<!-- -->

```r
meansteps<-mean(stepsPerDay$steps)
mediansteps<-median(stepsPerDay$steps)
```
The mean and median of the total number of steps taken per day are respectively 1.0766189\times 10^{4}  and 10765 .

## What is the average daily activity pattern ?


```r
stepsInterAvg<-aggregate(data=data,FUN=mean,steps~interval)

par(mfrow=c(1,1))
plot(unique(data$interval),stepsInterAvg$steps,main="Evolution of average steps during a day",xlab="Time",ylab="Number of steps (average)",type="l",col="blue")
```

![](PA1_template_files/figure-html/avg-1.png)<!-- -->

```r
maxinterval<-which.max(stepsInterAvg$steps)
maxtime<-stepsInterAvg$interval[maxinterval]
```
The maximum amount of steps done is in the inteval : 835 .

## Imputing missing values

```r
percentNA<-mean(is.na(data))*100
```
The percentage of missing values in the dataset is 4.3715847 % .  
We are going to replace missing values by the average of steps for that 5 minute interval.


```r
par(mfrow=c(1,1))
newdata<-data
for (i in 1:length(data$steps)){
    if (is.na(data$steps[i])){
        tmp<-data$interval[i]
        tmp2<-which(stepsInterAvg$interval==tmp)
        newdata$steps[i]<-stepsInterAvg$steps[tmp2]
    }
}
stepsPerDay2<-aggregate(data=newdata,FUN=sum,steps~date)
hist(stepsPerDay2$steps,main="Histogram Steps per day (changed NAs)",xlab = "Steps per day",col="red")
```

![](PA1_template_files/figure-html/meansteps2,mediansteps2-1.png)<!-- -->

```r
meansteps2<-mean(stepsPerDay2$steps)
mediansteps2<-median(stepsPerDay2$steps)
```
The new mean and median of total number of steps taken per day is respectively 1.0766189\times 10^{4} and 1.0766189\times 10^{4} .  
These values are slightly under the previous values, it is about 100 steps down.

## Are there differences in activity patterns between weekdays and weekends ?


```r
newdata["day"]<-character()
newdata$day<-as.character(newdata$day)
newdata$date<-as.Date(newdata$date)
tmp<-weekdays(newdata$date)
for (i in 1:length(newdata$date)){
    if(tmp[i]=="Samedi" || tmp[i]=="Dimanche"){
        newdata$day[i]<-"weekend"
    }
    else {
        newdata$day[i]<-"weekday"
    }
}
newdata$day<-as.factor(newdata$day)
stepsInterAvg2<-aggregate(data=newdata,FUN=mean,steps~interval+day)
par(mfrow=c(2,1))
plot(unique(stepsInterAvg2$interval),stepsInterAvg2$steps[1:288],main="Evolution of avg steps during weekday",xlab="Time",ylab = "Steps",type="l",ylim=c(0,250))

plot(unique(stepsInterAvg2$interval),stepsInterAvg2$steps[289:576],main="Evolution of avg steps during weekend",xlab="Time",ylab = "Steps",type="l",ylim=c(0,250))
```

![](PA1_template_files/figure-html/weekdays-1.png)<!-- -->
