# Plot3.R: Read data and Plot Time-series graphs of Sub-metering Data

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
png (filename="plot3.png", width=480, height=480, units="px")

plot(x=df$DateTime, y=df$Kitchen, col="black", type="l", xlab="", ylab="Energy Sub Metering")
lines(x=df$DateTime, y=df$Laundry, col="red", type="l")
lines(x=df$DateTime, y=df$Heater_AC, col="blue", type="l")
legend("topright", c("Sub_metering_1: Kitchen", "Sub_metering_2: Laundry", "Sub_metering_3: Heater_AC"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()
