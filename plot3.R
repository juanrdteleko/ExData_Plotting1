library(dplyr)
library(lubridate)

##We read each dataset from its source
##activity levels
data <- read.table("./data/household_power_consumption.txt",sep=";", header=TRUE,nrows=100)
Lines <- readLines("./data/household_power_consumption.txt")
subL <- grep("^[12]/2/2007",Lines)
## inSub <- read.table(text=Lines[subL], header = TRUE, sep = ";", dec = ".", na.strings = "?", colClasses = c(NA, NA, rep ("numeric", 7)))
inSub <- read.table(text=Lines[subL],sep=";", header = TRUE,dec = ".", na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
inSub_d <-inSub
inSub_d$Date <- as.Date(inSub$Date, "%d/%m/%Y")
DT <- as.POSIXct(as.character(paste(inSub_d$Date, inSub_d$Time), format="%Y/%m/%d %H.%M.%S"))
inSub_d <- cbind(DT,inSub_d)

par(mfrow=c(1,1),mar=c(4,4,2,1),oma=c(0,0,2,0)) ##settings plot properties

with(inSub_d,plot(DT,Sub_metering_1, col="black",type = "l", main="",xlab="",ylab = "Energy sub metering"))
with(inSub_d,lines(DT,Sub_metering_2, col="red",type = "l"))
with(inSub_d,lines(DT,Sub_metering_3, col="blue",type = "l"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black","red", "blue"), lty=1:1)
dev.copy(png,file = "plot3.png",width = 480, height = 480)
dev.off()