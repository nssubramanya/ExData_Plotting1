# Plot4.R: Read data and Plot 4 Graphs side-by-side

library(data.table)

# To find out number of rows to read
# $ grep "^[1|2]\/2\/2007;" household_power_consumption.txt | wc -l
# Result=2880. Matches with Number of Minutes in 2 days = 2 * 60 * 24 = 2880

df <- fread("household_power_consumption.txt", sep=";", 
            nrows=2880, 
            header=FALSE, 
            skip="1/2/2007", # Skips rows until it finds specified string
            data.table=FALSE, 
            stringsAsFactors = FALSE,
            col.names = c("Date", "Time",
                          "GlobalActivePower", "GlobalReactivePower", 
                          "Voltage", "GlobalIntensity",
                          "Kitchen", "Laundry", "Heater_AC"))

# Create a new variable by combining Date & Time
df$DateTime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")

# Plot the graph to a PNG
png (filename="plot4.png", width=480, height=480, units="px")

# Plot row-wise in a 2x2 matrix
par (mfrow=c(2,2))

# Global Active Power - Time Series
plot(x=df$DateTime, y=df$GlobalActivePower, type="l", 
     xlab="", ylab="Global Active Power", main="")

# Voltage Time Series
plot(x=df$DateTime, y=df$Voltage, type="l", 
     xlab="datetime", ylab="Voltage", main="")

# Sub Energy Metering - Time Series
plot(x=df$DateTime, y=df$Kitchen, col="black", type="l", xlab="", ylab="Energy Sub Metering")
lines(x=df$DateTime, y=df$Laundry, col="red", type="l")
lines(x=df$DateTime, y=df$Heater_AC, col="blue", type="l")

# In Legend, don't show the border and text should be smaller size than in plot3
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd="2", bty="n",
        cex=0.8, col=c("black", "red", "blue"))


# Global Reactive Power - Time Series
plot(x=df$DateTime, y=df$GlobalReactivePower, type="l", 
     xlab="datetime", ylab="Global Reactive Power", main="")

dev.off()
