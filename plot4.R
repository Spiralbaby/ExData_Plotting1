#load dplyr
library(dplyr)

#get colClassses
initial <- read.table("household_power_consumption.txt", nrows = 100)
classes <- sapply(initial, class)

#get data from file and put in data frame
data <- subset(read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes), Date == '1/2/2007' | Date == '2/2/2007')

#check for blanks:
any(is.na(data)) # False (no blanks or NA's)

#format dates
data <- mutate(data, asDate = as.Date(data$Date, "%d/%m/%Y"))
data <- within(data, { dateTimeAsChar=format(as.POSIXct(paste(asDate, Time)), "%d/%m/%Y %H:%M:%S") })
datetime = strptime(data$dateTimeAsChar, "%d/%m/%Y %H:%M:%S")


#open file device
png(file="plot4.png")

#format device
par(mfrow = c(2,2)) 
par(new=F)

#Graph1
with(data, plot(datetime, Global_active_power, type = "l", ylab="Global Active Power", xlab="")) 

#Graph2
with(data, plot(datetime, Voltage, type="l", xlab="datetime"))

#Graph3
yrange<-range(c(data$Sub_metering_1,data$Sub_metering_1,data$Sub_metering_1))
par(bty="n")
with(data, plot(datetime, Sub_metering_1, ylab="Energy sub metering", xlab="", type="l", col="Black", ylim=yrange))
par(new=T)
with(data, plot(datetime, Sub_metering_2, ylab="", xlab="", type="l", col="Red", ylim=yrange, xaxt='n', yaxt='n',ann=FALSE))
par(new=T, bty="o")
with(data, plot(datetime, Sub_metering_3, ylab="", xlab="", type="l", col="Blue", ylim=yrange, xaxt='n', yaxt='n',ann=FALSE))


legend("topright", lty=1, col = c("Black", "Red", "Blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n") 

#Graph4
par(new=F)
with(data, plot(datetime, Global_reactive_power, type="l"))

#close file device
dev.off()

