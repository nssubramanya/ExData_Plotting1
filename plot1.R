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


png (filename="plot1.png", width=480, height=480, units="px")
hist(df$GlobalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
