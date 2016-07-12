## This script makes a histogram of Global Active Power.
## It only includes 2/1/2007 and 2/2/2007.
## It sends a plot to the screen and also creates a PNG file.
## It needs to have the text file available at:
## "./data/household_power_consumption.txt" 
## and it only reads part of the file to get Feb 1 and 2, 2007.
par(mfrow=c(1,1))
elec <- read.csv("./data/household_power_consumption.txt", nrows = 69517, sep = ";", header = TRUE, stringsAsFactors = FALSE)
elec$newDate <- as.Date(elec$Date, format = "%d/%m/%Y")
elecFeb12 <- elec[(elec$newDate == "2007-02-01") | (elec$newDate == "2007-02-02"),]
elecFeb12$g_a_p2 <- as.numeric(elecFeb12$Global_active_power)
hist(elecFeb12$g_a_p2, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()