library("lubridate", lib.loc="~/R/win-library/3.3")
#Read data from working directory
elecdata <- read.table("Project1_household_power_consumption", sep = ";", na.strings = "?", header = TRUE)
#Select data from 2 relevant days
elecdata2 <- subset(elecdata, Date %in% c("1/2/2007","2/2/2007") )
#Convert Date and Time from factors to Date and POSIXlt
elecdata2$Date <- as.Date(elecdata2$Date, "%d/%m/%Y")
elecdata2$Time <- strptime(elecdata2$Time, "%H:%M:%S")
#Correct date value in Time column after conversion to POSIXlt
date(elecdata2$Time) <- date(elecdata2$Date)
#Create histogram and save to png file
hist(elecdata2$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
dev.copy(png, "plot1.png")
dev.off()