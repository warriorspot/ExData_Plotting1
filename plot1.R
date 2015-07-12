

fileName = "household_power_consumption.txt"
plotFileName = "plot1.png"

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

plot1 <- function(frame) {
    if(file.exists(plotFileName)) {
        file.remove(plotFileName)
    }
    png(plotFileName)
    par(bg = "white")
    par(fg = "black")
    par(cex = 0.75)
    hist(frame, ylim=c(0,1300), col = "red", main = "Global Active Power", xlab="Global Active Power (killowatts)", ylab="Frequency")    
    dev.off()
}

if(file.exists(fileName) == FALSE) {
    downloadData()
}
frame <- loadData()
plot1(frame$Global_active_power)
