# Read the data with read.table() with these parameters : sep=";",header=TRUE,na.string="?"
# Put the data into a variable called data
# Coerce the factor data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3 into numeric vectors.
# Subset from the data, the information we want : day 01/02/2007 and day 02/02/2007


### We use the lubridate package to use the function date() which access to the date of data$DateTime objects.
### I use this condition to avoid useless irerations if you are running the others scripts in this assignment.

library(lubridate)

data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
# Create a new column where we will combine Date and time, called DateTime. Only if you didn't run others scripts for this assignment as every script does that operation.
if(class(data$DateTime)!=c("POSIXlt","POSIXt")){
  data["DateTime"]<-NA
  data$DateTime<-paste(data$Date,data$Time)
  data$DateTime<-strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")
}
# Subsetting data that we want as in plot1.R
sub<-data[date(data$DateTime)>as.Date("31/01/2007",format="%d/%m/%Y") & date(data$DateTime)<as.Date("03/02/2007",format="%d/%m/%Y"),]

# "Jeu" stands for Thursday in french, "Ven" stands for Friday in french, "Sam" stands for Saturday in french
par(mfrow=c(1,1))
par(cex=0.5)
plot(sub$DateTime,sub$Sub_metering_1,col="black",xlab="",ylab = "Energy sub metering",type="l")
lines(x = sub$DateTime,y = sub$Sub_metering_2,col="red")
lines(x = sub$DateTime,y = sub$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty="solid")
dev.copy(png,file="plot3.png")
dev.off()