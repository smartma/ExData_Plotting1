plot2 <- function(){
  library(lubridate)
  
  dataUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  
  # Create a data folder if not already created
  # Assumes that if the directory exists then the data is present & unzipped
  
  if(!file.exists("data")){
    dir.create("data")
    
    # Download the data and unzip
    download.file(dataUrl, destfile="./data/household_power_consumption.zip")
    unzip(zipfile="./data/household_power_consumption.zip", exdir="./data")
  }
  # Read the data
  data <- read.table("./data/household_power_consumption.txt", header=FALSE, sep = ";", na.strings = "?", skip=1, colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  # Convert dates to date object & create a DateTime field (this uses Lubridate)
  data$DateTime <- dmy_hms(paste(data$Date, data$Time))
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  # Subset the data to only the two dates required
  data <- subset(data, data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"))

  # Set the Graphics Device to PNG 480x480
  png(file = "plot2.png", width = 480, height = 480, units = "px")
  
  # Generate the graph/plot
  plot(data$DateTime, data$Global_active_power, type = "n", xlab="", ylab="Global Active Power (kilowatts)")
  lines(data$DateTime, data$Global_active_power)
  
  # Close the Graphics Device to write to file
  dev.off()
}