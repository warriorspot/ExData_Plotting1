
fileName = "household_power_consumption.txt"
plotFileName = "plot3.png"

# Download and unzip the data file into the current working directory
downloadData <- function() {
    zipFileName = "pc.zip"
    fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
    download.file(fileURL, zipFileName)
    unzip(zipFileName)
}

# Load the data from the data file for the required time period
# and convert column classes as needed for plotting
loadData <- function(name = "household_power_consumption.txt") {
    allData <- read.csv(fileName, sep=";", stringsAsFactors=FALSE)
    allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")
    data <- allData[allData$Date >= as.Date("2007-02-01") & allData$Date <= as.Date("2007-02-02"),]
    data$Global_active_power <- as.double(data$Global_active_power)
  
    data
}

plot3 <- function(frame) {
    if(file.exists(plotFileName)) {
        file.remove(plotFileName)
    }
    png(plotFileName)
    plot(frame$Sub_metering_1, type="l", col="black", 
        xaxt="n", yaxt="n", xlab = "", ylab = "Energy sub metering")
    points(frame$Sub_metering_2, type="l", col="red")
    points(frame$Sub_metering_3, type="l", col="blue")
    legend(x="topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"), 
           lwd = "1")
    axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
    axis(2, at=seq(0,30, by = 10))
    dev.off()
}

if(file.exists(fileName) == FALSE) {
    downloadData()
}
frame <- loadData()
plot3(frame)
