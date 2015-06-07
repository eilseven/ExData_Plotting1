#The below part is for downloading and reading the data
library(RCurl) #getting the required package
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" #file URL to be downloaded
download.file(fileUrl, destfile="myfile.zip", method = "curl") #downloading the file in zip format
unzip("myfile.zip", files="household_power_consumption.txt") #unzipping the file and extracting it in txt format
file <- "household_power_consumption.txt" #copying the file name to be worked on
start <- grep("1/2/2007", readLines(file))[1] #finding the starting line which is 1/2/2007
end <- grep("3/2/2007", readLines(file))[1] #finding the end line which is the first data on 3/2/2007
data <- read.table(file, skip=start-1, nrows=end-start+1, sep=";") #getting only the required part of the data because of memory problems in CPU
colNames <- read.table(file, nrows=1, sep=";", header=TRUE) #getting column names in the original data
colnames(data) <- colnames(colNames) #adding header to the current data #pasting column names to our data

#Plotting Plot 3
Sys.setlocale("LC_TIME", "English") #Changing the language to English for x-label
date <- as.Date(data$Date, "%d/%m/%Y") #getting date in the appropriate format
dayNames <- weekdays(as.Date(date)) #defining the relevant day names
png(file="plot3.png") #opening png device
plot(data$Sub_metering_1, xaxt="n", type="l", col="black", lwd=0.7, ylab="Energy sub metering", xlab="")
my_axis_points = c(1, nrow(data)/2 + 1, nrow(data)) #defining axis points
axis(1, at=my_axis_points, labels=daynames[my_axis_points[1:3]], cex.axis= 1.0)
lines(data$Sub_metering_2, col="red", lwd=0.7)
lines(data$Sub_metering_3, col="blue", lwd=0.7)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=1, lwd=0.7, cex=1.0)
dev.off() #closing png device

