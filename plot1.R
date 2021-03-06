###########################################################################################
#   Title        - Exploratory Data Analysis - Week 1 - Course Project                    #
#   Script Name  - plot1.R                                                                #
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

# Open "png" device to write the plot to
png(filename = "plot1.png", bg = "transparent", width = 480, height = 480)
hist(energyData$Global_active_power
     , col="red"
     , main="Global Active Power"
     , xlab = "Global Active Power (kilowatts)"
     , ylab="Frequency"
     )

# Close the "png" device
dev.off()

# Clean up
rm(list=ls())

# End of script plot1.R