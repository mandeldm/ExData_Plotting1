powdata2 <- read.table("household_power_consumption.txt",
                                   sep=";",
                                   dec=".",
                                   header=TRUE,
                                   stringsAsFactors=FALSE,
                                   na.strings="?",
                                   colClasses=c(rep("character",2), rep("numeric",7)))

powdata2 <- within(powdata2, datetime <- paste(Date, Time))
powdata2$datetime2 <- strptime(powdata2$datetime, format="%d/%m/%Y %H:%M:%S")
powdata3 <- subset(powdata2, datetime2>=strptime("2007-02-01", format="%Y-%m-%d")
                   & datetime2<strptime("2007-02-03", format="%Y-%m-%d"))

plot(powdata3$datetime2, powdata3$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="")
points(powdata3$datetime2, powdata3$Sub_metering_2, type="l", 
       ylab="Energy sub metering", xlab="", col="red")
points(powdata3$datetime2, powdata3$Sub_metering_3, type="l", 
       ylab="Energy sub metering", xlab="", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, inset=0.08, bty="n")
# No box around the legend because it gets shifted by dev.copy when creating a png file.
dev.copy(png, file="plot3.png")
dev.off()