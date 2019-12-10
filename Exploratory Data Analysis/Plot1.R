# Read the data with read.table() with these parameters : sep=";",header=TRUE,na.string="?"
# Put the data into a variable called data
# Coerce the factor data$Global_Active_Power into a numeric vector 
# Create a new column with the information about the date & the time. It will be called DateTime
# Subset from the data, the information we want : day 01/02/2007 and day 02/02/2007


### We use the lubridate package to use the function date() which access to the date of data$DateTime objects.
### I use this condition to avoid useless irerations if you are running the others scripts in this assignment.
library(lubridate)

if(class(data$DateTime)!=c("POSIXlt","POSIXt")){
  data["DateTime"]<-NA
  data$DateTime<-paste(data$Date,data$Time)
  data$DateTime<-strptime(data$DateTime,format="%d/%m/%Y %H:%M:%S")
}

data$Global_active_power<-as.numeric(data$Global_active_power)
sub<-data[date(data$DateTime)>as.Date("31/01/2007",format="%d/%m/%Y") & date(data$DateTime)<as.Date("03/02/2007",format="%d/%m/%Y"),]

par(mfrow=c(1,1))

hist(sub$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()
