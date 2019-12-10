# Read the data with read.table() with these parameters : sep=";",header=TRUE,na.string="?"
# Put the data into a variable called data
# Subset from the data, the information we want : day 01/02/2007 and day 02/02/2007
### We use the lubridate package to use the function date() which access to the date of data$DateTime objects.
### I use this condition to avoid useless irerations if you are running the others scripts in this assignment.
# Coerce columns we need into numeric vectors : Global active power, Global reactive power, Voltage, Sub metering 1,Sub metering 2, Sub metering 3.

library(lubridate)

# Create a new column where we will combine Date and time, called DateTime
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
if(class(data$DateTime)!=c("POSIXlt","POSIXt")){
  data["DateTime"]<-NA
  data$DateTime<-paste(data$Date,data$Time)
  data$DateTime<-strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")
}
sub<-data[date(data$DateTime)>as.Date("31/01/2007",format="%d/%m/%Y") & date(data$DateTime)<as.Date("03/02/2007",format="%d/%m/%Y"),]

# "Jeu" stands for Thursday in french, "Ven" stands for Friday in french, "Sam" stands for Saturday in french
par(cex=2)
par(mfrow=c(2,2))
# Here i struggled to have a nice looking legend box in the topright of the third plot, so i created a Date and time variable
# to manually change the position of the box. I will use this variable in the legend() function.
box=strptime("01/02/2007 23:00:00",format="%d/%m/%Y %H:%M:%S")


plot(sub$DateTime,sub$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatt)")
plot(sub$DateTime,sub$Voltage,type="l",xlab="datetime",ylab="Voltage",col="black")
plot(sub$DateTime,sub$Sub_metering_1,col="black",xlab="",ylab = "Energy sub metering",type="l")
lines(x = sub$DateTime,y = sub$Sub_metering_2,col="red")
lines(x = sub$DateTime,y = sub$Sub_metering_3,col="blue")
legend(x=box,y=43,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty="solid",cex=0.55,y.intersp = 0.25,x.intersp = 0.3,bty="n")
plot(sub$DateTime,sub$Global_reactive_power,type="l",xlab = "datetime",ylab = "Global_reactive_power",col="black")

dev.copy(png,file="plot4.png")
dev.off()