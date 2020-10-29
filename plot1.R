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
  
   ## Name the vector
	dateTime <- setNames(dateTime, "DateTime")
  
   ## Remove Date and Time column
	file <- file[ ,!(names(file) %in% c("Date","Time"))]
	  
   ## Add DateTime column
	file <- cbind(dateTime, file)
  
   ## Format dateTime Column
	file$dateTime <- as.POSIXct(dateTime)

#PLOT 1: Histogram of Global Active Power(kilowatts)
hist(file$Global_active_power, col= "red", xlab= "Global Active Power (kilowatts)", main= "Global Active Power")

   ## Save file. DO NOT FORGET to close.
      dev.copy(png,"plot1.png", width=480, height=480)
      dev.off()
