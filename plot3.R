# plot3.R
library(dplyr)

# Load Data
# I assume the file is downloaded and stored in the working directory as household_power_consumption.txt
# read first lines to determine classes, then read whole document (to speed up reading in)
init  <- read.csv("household_power_consumption.txt", nrow=3, sep=";")
classes  <- sapply(init,class)
power  <- read.csv("household_power_consumption.txt", sep=";", colClasses=classes, na.strings="?")

# convert dates and filter dates
power  <- mutate(power,Date2=as.Date(strptime(Date,"%d/%m/%Y")))
ourdates  <- subset(power, Date2 >= "2007-02-01" & Date2 <= "2007-02-02" )
# inlcude time in a new field
ourdates$datetime  <- strptime(paste(ourdates$Date,ourdates$Time),"%d/%m/%Y %H:%M:%S")

# Create plot
# png file
png(file="plot3.png")
with(ourdates,plot(datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(ourdates,lines(datetime,Sub_metering_2,col="Red"))
with(ourdates,lines(datetime,Sub_metering_3,col="Blue"))
legend("topright", col=c("Black","Red","Blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)

# Save to png
dev.off()