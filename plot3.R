## This script plots watt-hours by sub-meter for 2/1 - 2/2/07.
## It sends a plot to the screen and also creates a PNG file.
## It needs to have the text file available at:
## "./data/household_power_consumption.txt" 
## and it only reads part of the file to get Feb 1 and 2, 2007.

par(mfrow=c(1,1))
elec <- read.csv("./data/household_power_consumption.txt", nrows = 69517, sep = ";", header = TRUE, stringsAsFactors = FALSE)
elec$newDate <- as.Date(elec$Date, format = "%d/%m/%Y")
elecFeb12 <- elec[(elec$newDate == "2007-02-01") | (elec$newDate == "2007-02-02"),]
elecFeb12$completeDT <- strptime(paste(elecFeb12$Date, elecFeb12$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
elecFeb12$sub_m1 <- as.numeric(elecFeb12$Sub_metering_1)
elecFeb12$sub_m2 <- as.numeric(elecFeb12$Sub_metering_2)
elecFeb12$sub_m3 <- as.numeric(elecFeb12$Sub_metering_3)
plot(elecFeb12$completeDT, elecFeb12$sub_m1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(elecFeb12$completeDT, elecFeb12$sub_m2, col = "red")
lines(elecFeb12$completeDT, elecFeb12$sub_m3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()