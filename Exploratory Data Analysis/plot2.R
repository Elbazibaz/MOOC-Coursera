# Read the data with read.table() with these parameters : sep=";",header=TRUE,na.string="?"
# Put the data into a variable called data
# Coerce the data$Date into a date using as.Date(data$Date,format="%d/%m/%Y")
# Subset from the data, the information we want : day 01/02/2007 and day 02/02/2007
# With that command sub<-data[data$Date>as.Date("31/01/2007",format="%d/%m/%Y") & data$Date<as.Date("03/02/2007",format="%d/%m/%Y"),]

### We use the lubridate package to use the function date() which access to the date of data$DateTime objects.
### I use this condition to avoid useless irerations if you are running the others scripts in this assignment.

library(lubridate)

# Create a new column where we will combine Date and time, called DateTime
if(class(data$DateTime)!=c("POSIXlt","POSIXt")){
  data["DateTime"]<-NA
  data$DateTime<-paste(data$Date,data$Time)
  data$DateTime<-strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")
}
data$Global_active_power<-as.numeric(data$Global_active_power)
# Subsetting data that we want as in plot1.R
#data$Date<-as.Date(data$Date,format="%d/%m/%Y")
#sub<-data[data$Date>as.Date("31/01/2007",format="%d/%m/%Y") & data$Date<as.Date("03/02/2007",format="%d/%m/%Y"),]
sub<-data[date(data$DateTime)>as.Date("31/01/2007",format="%d/%m/%Y") & date(data$DateTime)<as.Date("03/02/2007",format="%d/%m/%Y"),]

par(mfrow=c(1,1))
plot(sub$DateTime,sub$Global_active_power,type="l",xlab = "",ylab = "Global Active Power (kilowatt)")
# "Jeu" stands for Thursday in french, "Ven" stands for Friday in french, "Sam" stands for Saturday in french
dev.copy(png,file="plot2.png")
dev.off()
