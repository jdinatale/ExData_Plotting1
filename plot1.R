## R script constructs a histogram of minute-averaged global active power between 2/1/2007 and 2/2/2007
## and saves it as plot1.png

## Check for data in current directory and download and unzip if not present.
if (!file.exists("./household_power_consumption.txt")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url, destfile = "HPC.zip", method = "curl")
    unzip("HPC.zip")
}

## read in data file
power <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", comment.char="", 
                    colClasses=c(rep("character", 2), rep("numeric",7)), nrows=2075259)

##subset data 
pwrsmpl <- power[(power$Date=="1/2/2007" | power$Date=="2/2/2007"),]

##generate histogram

hist(pwrsmpl$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
