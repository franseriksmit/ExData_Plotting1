library(dplyr)
library(lubridate)
library(sqldf)

## load data get  metadata(colnames)
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<-"power.zip"
if(!file.exists(filename)){download.file(fileurl, filename)}
if(!file.exists("power")){unzip(filename)}
tabel<-read.csv.sql("household_power_consumption.txt", sql="select * from file where Date in ('1/2/2007','2/2/2007')", sep=";")
closeAllConnections()
tabel$Date<-as.Date(tabel$Date, format="%d/%m/%Y")
tabel$DateTime<-as.POSIXct(paste(tabel$Date, as.character(tabel$Time)))
par(mfrow=c(2,2))
Sys.setlocale(category = "LC_ALL", locale = "english")
with(tabel, plot(Global_active_power ~ DateTime, type="l", ylab="Global Active Power", xlab=""))
with(tabel, plot(Voltage ~ DateTime, type="l", xlab="datetime"))
with(tabel, plot(Sub_metering_1 ~ DateTime, type="l", col="black",  ylab="Enery sub metering", xlab=""))
lines(tabel$Sub_metering_2 ~ tabel$DateTime, col="red")
lines(tabel$Sub_metering_3 ~ tabel$DateTime, col="blue")
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , col=c("black","red", "blue"), pch=151)
with(tabel, plot(Global_reactive_power ~ DateTime, type="l", ylab="Global_reactive_power", xlab="datetime"))
dev.copy(png, 'plot4.png')
dev.off()