#READING THE DATA
file <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
   ## Format date to Type Date
	file$Date <- as.Date(file$Date, "%d/%m/%Y")
  
   ## Use only data from 2007-02-01 to 2007-02-02
	file <- subset(file, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
  
   ## Remove incomplete observation
	file <- file[complete.cases(file),]

   ## Combine Date and Time column
	dateTime <- paste(file$Date, file$Time)
	dateTime <- setNames(dateTime, "DateTime")
	file <- file[ ,!(names(file) %in% c("Date","Time"))]
	file <- cbind(dateTime, file)
  
   ## Format dateTime Column
	file$dateTime <- as.POSIXct(dateTime)

#PLOT 4: 2-by-2 graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,0,0))

   ##Upper left
     plot(file$Global_active_power~file$dateTime, type="l", xlab="", ylab="Global Active Power")

   ##Upper Right
     plot(file$Voltage~file$dateTime, type="l", xlab="datetime", ylab="Voltage")

   ##Lower Left
     plot(file$Sub_metering_1 ~ file$dateTime, type="l", xlab="", 
          ylab="Energy Sub Metering")
     lines(file$Sub_metering_2 ~ file$dateTime, col="red") 
     lines(file$Sub_metering_3 ~ file$dateTime, col="blue") 
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
          c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

   ##Lower Right 
     with(file, plot(Global_reactive_power~dateTime, type="l", xlab="datetime"))

   ## Save file. DO NOT FORGET to close.
      dev.copy(png,"plot4.png", width=480, height=480)
      dev.off()
