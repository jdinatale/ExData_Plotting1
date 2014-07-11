## R script constructs a line plot of minute-averaged global active power between 2/1/2007 and 2/2/2007
## and saves it as plot2.png

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
png("./plot2.png")
plot(datetime, pwrsmpl$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

