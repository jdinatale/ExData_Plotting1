## R script constructs a 4 chart plot which includes plot2 and plot3 as well as plots of voltage 
## and global reactive power values for 2/1/2007 and 2/2/2007 and saves it as plot3.png

## Check for data in current directory and download and unzip if not present.
if (!file.exists("./household_power_consumption.txt")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "HPC.zip", method = "curl")
    unzip("HPC.zip")
}

## read in data file
power <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", comment.char="", 
                    colClasses=c(rep("character", 2), rep("numeric",7)), nrows=2075259)

## subset data and combine date and time columns 
pwrsmpl <- power[(power$Date=="1/2/2007" | power$Date=="2/2/2007"),]
datetime <- strptime(paste(pwrsmpl$Date, pwrsmpl$Time), "%d/%m/%Y %H:%M:%S")

## generate plot
## Note: default (white) background is used due to inconsistencies in how certain viewers
## render transparent backgrounds.
png("./plot4.png")

par(mfcol=c(2, 2))

plot(datetime, pwrsmpl$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

plot(datetime, pwrsmpl$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, pwrsmpl$Sub_metering_2, col="red")
lines(datetime, pwrsmpl$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"),
       lty=1)

plot(datetime, pwrsmpl$Voltage, type="l", ylab="Voltage")

plot(datetime, pwrsmpl$Global_reactive_power, type="l", ylab="Global_reactive_power")

dev.off()
