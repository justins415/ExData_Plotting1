## This script creates four plots in a 2 x 2 arrangement.
## It sends it to the screen and also creates a PNG file.
## It needs to have the text file available at:
## "./data/household_power_consumption.txt" 
## and it only reads part of the file to get Feb 1 and 2, 2007.
## Chill.
elec <- read.csv("./data/household_power_consumption.txt", nrows = 69517, sep = ";", header = TRUE, stringsAsFactors = FALSE)
elec$newDate <- as.Date(elec$Date, format = "%d/%m/%Y")
elecFeb12 <- elec[(elec$newDate == "2007-02-01") | (elec$newDate == "2007-02-02"),]
elecFeb12$completeDT <- strptime(paste(elecFeb12$Date, elecFeb12$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
elecFeb12$g_a_p2 <- as.numeric(elecFeb12$Global_active_power)
elecFeb12$g_r_p2 <- as.numeric(elecFeb12$Global_reactive_power)
par(mfcol = c(2,2))
## Plot #1
plot(elecFeb12$completeDT, elecFeb12$g_a_p2, type = "l", xlab = "", ylab = "Global Active Power")
## Plot #2
elecFeb12$sub_m1 <- as.numeric(elecFeb12$Sub_metering_1)
elecFeb12$sub_m2 <- as.numeric(elecFeb12$Sub_metering_2)
elecFeb12$sub_m3 <- as.numeric(elecFeb12$Sub_metering_3)
plot(elecFeb12$completeDT, elecFeb12$sub_m1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(elecFeb12$completeDT, elecFeb12$sub_m2, col = "red")
lines(elecFeb12$completeDT, elecFeb12$sub_m3, col = "blue")
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), cex = 0.5, bty = "n")
## Plot #3
plot(elecFeb12$completeDT, elecFeb12$Voltage, type="l", xlab = "datetime", ylab = "Voltage")
## Plot #4
plot(elecFeb12$completeDT, elecFeb12$g_r_p2, type="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()