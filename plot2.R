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

#Formatting
par(col = "black")
par(mfrow = c(1,1)) 

#open file device
png(file="plot2.png")

with(data, plot(datetime, Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))

#close file device
dev.off()
