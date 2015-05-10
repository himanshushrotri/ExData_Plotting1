###########################################################################################
#   Title        - Exploratory Data Analysis - Week 1 - Course Project                    #
#   Script Name  - plot4.R                                                                #
#   Author       - Himanshu Shrotri                                                       #
#   Date Created - Sun, 10 May 2015                                                       #
#   Purpose      - Reading "UC Irvine Machine Learning Repository" as raw dataset         #
#                  containing "individual household electric power consumption" data and  #
#                  examining how household energy usage varies over a 2-day period in     #
#                  February, 2007.                                                        #
###########################################################################################


# Initialize Variables related to project working directory and related files
currDir     <- getwd()
zipFileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile     <- "powerConsumption.zip"
txtFileName <- "household_power_consumption.txt"
lowDate     <- "1/2/2007"
highDate    <- "2/2/2007"

# Check if text data file exists, if not then download the zip file and unzip file.
if (!file.exists(txtFileName)) {
        print("Project data missing; downloading from source. Please Wait...")
        download.file(zipFileUrl, destfile = zipFile, method = "curl")
        unzip(zipFile, exdir = "./")
        #file.remove(zipFile)
}

stopifnot(file.exists(txtFileName))
print("Reading Files. Please Wait...")

# Read raw data from the file; convert any "?" to NAs.
rawData <- read.table(file = txtFileName
                     , header = TRUE
                     , sep = ";"
                     , na.strings='?'
                     , colClasses=c(rep('character', 2),rep('numeric', 7))
                     ) 

# Only subset data that is required for this project (1st and 2nd Feb)
energyData <- subset(rawData, Date %in% c(lowDate, highDate))
# Remove rawData from memory
rm(rawData)

# Convert Date column to date format using strptime function
energyData$DateTime <- strptime(paste(energyData$Date, energyData$Time), "%d/%m/%Y %H:%M:%S")

# Open "png" device to write the plot to
png(filename = "plot4.png", bg = "transparent", width = 480, height = 480)

# Set plotting area for 2x2 graphs
par(mfrow = c(2,2))

# Plot Graph 1
with(energyData
     , plot(DateTime
            , Global_active_power
            , type="l"
            , xlab=""
            , ylab="Global Active Power"
     )
)


# Plot Graph 2
with(energyData
     , plot(DateTime
            , Voltage
            , type="l"
            , xlab="datetime"
            , ylab="Voltage"
     )
)

# Plot Graph 3
with(energyData
     , plot(DateTime
            , Sub_metering_1
            , type="n"
            , xlab=""
            , ylab="Energy sub metering"
            )
     )

# Add 3 data points to the plot
with(energyData, points(DateTime, Sub_metering_1, type="l", col="black"))
with(energyData, points(DateTime, Sub_metering_2, type="l", col="red"))
with(energyData, points(DateTime, Sub_metering_3, type="l", col="blue"))

# Add legend on top right corner
legend("topright"
       , lty="solid"
       , col=c("black", "red", "blue")
       , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , bty = "n"
       )

# Plot Graph 4
with(energyData
     , plot(DateTime
            , Global_reactive_power
            , type="l"
            , xlab="datetime"
            , ylab="Global_reactive_power"
     )
)
     
# Close the "png" device
dev.off()

# Clean up
rm(list=ls())
# End of script plot4.R