#Download dataset first into working directory#
# Read the dataset into R keeping in mind that the table has a header, that the separator is a semicolon, NA values are represented as "?"#
# Retain the data as text, don't convert into factors - I found it easier to convert into R specific Date and Time#
power<-read.table("~/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)

#Need to convert Date and Time into R format#
#Concatenate them into one column, and then apply strptime on it
power$TimeStamp<-paste(power$Date, power$Time)
power$TimeStamp<-strptime(power$TimeStamp, "%d/%m/%Y %H:%M:%S")

#Create a subset to only pull date between Feb 1, 2007 and Feb 2, 2007#
powersubset<-subset(power, TimeStamp >= "2007-02-01 00:00:00" & TimeStamp <= "2007-02-02 23:59:59")

#Create file plot3.png with required height and width#
png(filename="plot3.png", width=480, height=480, units="px")

#This plot needs 3 variables to be plotted, so use points to add to existing plot. 
plot(powersubset$TimeStamp, powersubset$Sub_metering_1, type="s", xlab="", ylab="Energy sub metering")
points(powersubset$TimeStamp, powersubset$Sub_metering_2, type="s", col="red")
points(powersubset$TimeStamp, powersubset$Sub_metering_3, type="s", col="blue")
legend("topright", lwd=c(2,2,2), col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Since we asked to write to a png device, make sure to turn off the device once that's done.
dev.off()