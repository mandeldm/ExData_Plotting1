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

par_default <- par(no.readonly = TRUE)

par(mfrow = c(2, 2), mar = c(4, 5, 0.5, 0.5), oma = c(0, 0, 0, 0))
with(powdata3, {
        plot(datetime2, Global_active_power,
             type="l", ylab="Global Active Power", xlab="")
        plot(datetime2, Voltage,
             type="l", ylab="Voltage", xlab="datetime")
        plot(powdata3$datetime2, powdata3$Sub_metering_1, type="l", 
             ylab="Energy sub metering", xlab="")
        points(powdata3$datetime2, powdata3$Sub_metering_2, type="l", 
               ylab="Energy sub metering", xlab="", col="red")
        points(powdata3$datetime2, powdata3$Sub_metering_3, type="l", 
               ylab="Energy sub metering", xlab="", col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col=c("black", "red", "blue"), lty=1, inset=0.15, bty="n")
        plot(datetime2, Global_reactive_power,
             type="l", ylab="Global_reactive_power", xlab="datetime")
})
dev.copy(png, file="plot4.png")
dev.off()

par(par_default)
# Restoring previous parameters so that subsequent graphs are not placed in 2x2 grid etc
        