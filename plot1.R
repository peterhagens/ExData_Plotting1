# plot1.R
library(dplyr)

# Load Data
# I assume the file is downloaded and stored in the working directory as household_power_consumption.txt
# read first lines to determine classes, then read whole document (to speed up reading in)
init  <- read.csv("household_power_consumption.txt", nrow=3, sep=";")
classes  <- sapply(init,class)
power  <- read.csv("household_power_consumption.txt", sep=";", colClasses=classes, na.strings="?")

# convert dates and filter dates
power  <- mutate(power,Date=as.Date(strptime(Date,"%d/%m/%Y")))
ourdates  <- subset(power, Date >= "2007-02-01" & Date <= "2007-02-02" )

# Create plot
with(ourdates, hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power" ))

# Save to png
dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
