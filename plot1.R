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

#Plot1
class(twodays$Global_active_power)
twodays$Global_active_power = as.numeric(twodays$Global_active_power)
png("plot1.png", width = 480, height = 480)
hist(twodays$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", ylim=c(0, 1200) )
dev.off()


