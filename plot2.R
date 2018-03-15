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

#Plot2
tmp <- strptime(twodays$Time, format = "%H:%M:%S")
tmp2 <- sub(".*\\s+", "",  tmp)
twodays$Time <- tmp2
twodays$datetime <- with(twodays, as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))
png("plot2.png", width = 480, height = 480)
plot(Global_active_power ~ datetime, data=twodays, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

