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

#Create file plot2.png with required height and width#
png(filename="plot2.png", width=480, height=480, units="px")

#Create plot of Datetime vs Global Active Power, type is set to s for stair steps with appropriate axis labels# 
plot(powersubset$TimeStamp, powersubset$Global_active_power, type="s", xlab="", ylab="Global Active Power (kilowatts)")

#Since we asked to write to a png device, make sure to turn off the device once that's done. 
dev.off()