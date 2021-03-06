
fileName = "household_power_consumption.txt"
plotFileName = "plot2.png"

# Download and unzip the data file into the current working directory
downloadData <- function() {
    zipFileName = "pc.zip"
    fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    
    download.file(fileURL, zipFileName, method="curl")
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

plot2 <- function(frame) {
    if(file.exists(plotFileName)) {
        file.remove(plotFileName)
    }
    png(plotFileName)
    par(bg = "white")
    par(fg = "black")
    #par(cex = 0.75)
    plot(frame, type="l", xlab="", ylab="Global Active Power (killowatts)", xaxt="n")
    axis(1, at=c(0, 1440, 2880), labels=c("Thu", "Fri", "Sat"))
    dev.off()
}

if(file.exists(fileName) == FALSE) {
    downloadData()
}
frame <- loadData()
plot2(frame$Global_active_power)
