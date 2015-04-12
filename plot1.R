# read.table, read.csv
# quote="" means not quotes
# na.strings - set the character that represents a missing value (?)
# nrows (how many rows to read)

data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", nrows = 10)

#Try look up paste then the as.POSIXct function. Those helped me in converting the Date and Time to the format we need.

#in R reading large tables, good pointers to use to speed up import & estimating size


initial <- read.table("household_power_consumption.txt", nrows = 100)
classes <- sapply(initial, class)
data <- subset(read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = classes), Date == '1/2/2007' | Date == '2/2/2007')

hist(data$Global_active_power)