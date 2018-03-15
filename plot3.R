#read in the data
full_data <- read.table("/Users/beckycarlyle/Dropbox/Coursera/Data Science/Module 4_Exploratory data analysis/household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = F)

class(full_data$Date)
#convert first column from factor to date
full_data$Date <- as.Date(full_data$Date, format="%d/%m/%Y")

library(dplyr)
#filter to retain the two days required
twodays <- full_data %>%
  filter(Date >= "2007-02-01" & Date <= "2007-02-02" )
#remove the large table
rm(full_data)

tmp <- strptime(twodays$Time, format = "%H:%M:%S")
tmp2 <- sub(".*\\s+", "",  tmp)
twodays$Time <- tmp2
twodays$datetime <- with(twodays, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))

#Plot3
plot(Sub_metering_1 ~ datetime, data = twodays, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(Sub_metering_2 ~ datetime, data = twodays, type = "l", col="red")
lines(Sub_metering_3 ~ datetime, data = twodays, type = "l", col="blue")
legend("topright", legend = colnames(twodays[7:9]), col = c("black", "red", "blue"), lty = "solid")
png("plot3.png", width = 480, height = 480)
dev.off()

