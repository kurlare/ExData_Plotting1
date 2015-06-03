
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

## Plot 2, a linegraph chart of Global Active Power over time. 
plot(power_usage$Date.Time,power_usage$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Create plot2.png file in working directory.
png(filename = "plot2.png")
plot(power_usage$Date.Time,power_usage$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()