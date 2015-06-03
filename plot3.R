
## Read text file, retain headers and adjust for separating value, NA's.
power_df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Create empty data.table, fill with all rows for relevant dates and remove NA's.  
power_usage <- data.table()
power_usage <- rbind(power_df[power_df$Date == "1/2/2007",], power_df[power_df$Date == "2/2/2007",])
power_usage <- na.omit(power_usage)


## Combine Date & Time variables into one column and change class.
power_usage$Date <- dmy(power_usage$Date)
power_usage <- unite(power_usage, col = "Date.Time", Date, Time, sep = "_")
power_usage$Date.Time <- ymd_hms(power_usage$Date.Time)
power_usage$Date.Time <- as.POSIXct(power_usage2$Date.Time)

## Plot 3, a line graph for all sub-metering values over time.
plot(power_usage$Date.Time, power_usage$Sub_metering_1, type = "l", 
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(power_usage$Date.Time, power_usage$Sub_metering_2, type = "l", col = "red")
lines(power_usage$Date.Time, power_usage$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Create plot3.png file in working directory.
png(filename = "plot3.png")
plot(power_usage$Date.Time, power_usage$Sub_metering_1, type = "l", 
     col = "black", xlab = "", ylab = "Energy sub metering")
lines(power_usage$Date.Time, power_usage$Sub_metering_2, type = "l", col = "red")
lines(power_usage$Date.Time, power_usage$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()