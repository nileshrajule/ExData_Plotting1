#Read sample data from input file to determine classes of columns
sampleData <- read.table("household_power_consumption.txt",
                         sep = ";", header = TRUE, nrows = 5)
classes <- sapply(sampleData, class)

#Read the complete data from input file
rawData <- read.table("household_power_consumption.txt",
                       header = TRUE, sep = ";", colClasses = classes,
                       na.strings="?")

#Convert Date column to date format
rawData$Date <- as.Date(rawData$Date, format="%d/%m/%Y")

#Subset required data 
data <- subset(rawData, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
                     
#Merge Data and Time columns into timeStamp column 
data$timeStamp <- paste(data$Date, data$Time)

#Convert timeStrap column to date and time format
data$timeStamp <- strptime(data$timeStamp, "%Y-%m-%d %H:%M:%S")

#______________________________________________________________________________________

#Third plot
png(file="plot3.png",width=480,height=480)
with(data, {
  plot(timeStamp, Sub_metering_1, type = "l",
       xlab = "",
       ylab = "Engery sub metering")
  lines(data$timeStamp, data$Sub_metering_2, type = "l",
        col ="red")
  lines(data$timeStamp, data$Sub_metering_3, type = "l",
        col ="blue")
  legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"),lty = 1)
})
dev.off()