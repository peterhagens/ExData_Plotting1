# plot2.R
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
with(ourdates,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power(kilowatts)"))

# Save to png
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()