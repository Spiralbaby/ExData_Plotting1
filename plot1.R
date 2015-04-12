#get colClassses
initial <- read.table("household_power_consumption.txt", nrows = 100)
classes <- sapply(initial, class)

#get data from file and put in data frame
data <- subset(read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes), Date == '1/2/2007' | Date == '2/2/2007')
#check for blanks:
any(is.na(data)) # False (no blanks or NA's)

#format device
par(mfrow = c(1,1)) 

#open file device
png(file="plot1.png")

#create graph
hist(data$Global_active_power, col = "Red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#close file device
dev.off()
