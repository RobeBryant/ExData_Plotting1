library("lubridate", lib.loc="~/R/win-library/3.3")
library("dplyr", lib.loc="~/R/win-library/3.3")
#Read data from working directory
elecdata <- read.table("Project1_household_power_consumption", sep = ";", na.strings = "?", header = TRUE)
#Select data from 2 relevant days
elecdata2 <- subset(elecdata, Date %in% c("1/2/2007","2/2/2007") )
#Convert Date and Time from factors to Date and POSIXlt
elecdata2$Date <- as.Date(elecdata2$Date, "%d/%m/%Y")
elecdata2$Time <- strptime(elecdata2$Time, "%H:%M:%S")
#Correct date value in Time column after conversion to POSIXlt
date(elecdata2$Time) <- date(elecdata2$Date)
#Sort data by Time before plotting time series (need to convert to POSIXct)
elecdata2$Time <- as.POSIXct(elecdata2$Time)
arrange(elecdata2, Time)
#Determine number of data points in each day in order to determine x axis labels
table(elecdata2$Date)
#Create time series plot
ts.plot(cbind(elecdata2$Sub_metering_1, elecdata2$Sub_metering_2, elecdata2$Sub_metering_3), 
        gpars = list(ylab = "Energy sub metering", xlab = "",xaxt="n", 
                     col = c("black", "red", "blue")))
axis(labels = c("Thu", "Fri","Sat"), side = 1, at=c(1,1441,2880))
legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ), lwd = 2, cex = 0.75, 
       pt.cex = 1, y.intersp = 0.5, x.intersp = 0.25, text.width = 600)
dev.copy(png, "plot3.png")
dev.off()