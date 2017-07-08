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
hist(tabel$Global_active_power, col="red", main="Global active power", xlab="Global Active Power (kilowatts)")
dev.copy(png, 'plot1.png')
dev.off()