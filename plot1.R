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

hist(powdata3$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")
dev.copy(png, file="plot1.png")
dev.off()