#read in the data
full_data <- read.table("/Users/beckycarlyle/Dropbox/Coursera/Data Science/Module 4_Exploratory data analysis/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = F)
#read.delim()
head(full_data)

class(full_data$Date)
#convert first column from factor to date
full_data$Date <- as.Date(full_data$Date, format="%d/%m/%Y")
head(full_data)
library(dplyr)
twodays_2 <- twodays
#filter to retain the two days required
twodays <- full_data %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02" )
#check it has worked
table(twodays$Date)
#remove the large table
rm(full_data)

#Plot1
class(twodays$Global_active_power)
twodays$Global_active_power = as.numeric(twodays$Global_active_power)
hist(twodays$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", ylim=c(0, 1200) )
png("plot1.png", width = 480, height = 480)
dev.off()
#Plot2
tmp <- strptime(twodays$Time, format = "%H:%M:%S")
tmp2 <- sub(".*\\s+", "",  tmp)
twodays$Time <- tmp2
twodays$datetime <- with(twodays, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))
plot(Global_active_power ~ datetime, data=twodays, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
png("plot2.png", width = 480, height = 480)
dev.off()
#Plot3
plot(Sub_metering_1 ~ datetime, data = twodays, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_2 ~ datetime, data = twodays, type = "l", col="red")
lines(Sub_metering_3 ~ datetime, data = twodays, type = "l", col="blue")
legend("topright", legend = colnames(twodays[7:9]), col = c("black", "red", "blue"), lty = "solid")
png("plot3.png", width = 480, height = 480)
dev.off()

#Plot4
par(mfrow = c(2,2))
plot(Global_active_power ~ datetime, data=twodays, type="l", xlab = "", ylab = "Global Active Power")
plot(Voltage ~ datetime, data=twodays, type="l", xlab = "datetime", ylab = "Voltage")
plot(Sub_metering_1 ~ datetime, data = twodays, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_2 ~ datetime, data = twodays, type = "l", col="red")
lines(Sub_metering_3 ~ datetime, data = twodays, type = "l", col="blue")
legend("topright", legend = colnames(twodays[7:9]), col = c("black", "red", "blue"), lty = "solid", cex=0.8, box.lwd=0, bty="o")
plot(Global_reactive_power ~ datetime, data=twodays, type="l", xlab = "datetime", ylab = "Global_reactive_power")
png("plot4.png", width = 480, height = 480)
dev.off()
