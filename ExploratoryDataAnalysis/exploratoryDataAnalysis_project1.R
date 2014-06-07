
Sys.setlocale("LC_TIME", "English")

##Get data
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "household_power_consumption.zip")
unzip("household_power_consumption.zip", exdir=getwd())

#Extract data
df= read.table("household_power_consumption.txt", sep=";",header=TRUE)
str(df)

##extract the two days
sub.df = subset(df, as.Date(Date, format = "%d/%m/%Y") >= "2007-02-01" & 
                  as.Date(Date, format = "%d/%m/%Y") <= "2007-02-02")
##merge time and date
sub.df$datetime = strptime(paste(sub.df$Date,sub.df$Time), format = "%d/%m/%Y %H:%M:%S")
str(sub.df)

#Global Active Power Hist-plot (plot1)

sub.df$Global_active_power = as.numeric(as.character(sub.df$Global_active_power))
png(filename="plot1.png", width=480, height=480)
hist(sub.df$Global_active_power,col = "red" , xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")
dev.off()

##Global Active Power Time series plot (plot2)
png(filename="plot2.png", width=480, height=480)
plot(sub.df$datetime, sub.df$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#Energy sub metering time series plot (plot3)
sub.df$Sub_metering_1 = as.numeric(as.character(sub.df$Sub_metering_1))
sub.df$Sub_metering_2 = as.numeric(as.character(sub.df$Sub_metering_2))
sub.df$Sub_metering_3 = as.numeric(as.character(sub.df$Sub_metering_3))
png(filename="plot3.png", width=480, height=480)
plot(sub.df$datetime, sub.df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(sub.df$datetime, sub.df$Sub_metering_2, col="red")
lines(sub.df$datetime, sub.df$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       col=c("black", "red", "blue"))
dev.off()

##Last plot (plot4)
png(filename="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

plot(sub.df$datetime, sub.df$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

sub.df$Voltage = as.numeric(as.character(sub.df$Voltage))
plot(sub.df$datetime, sub.df$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

plot(sub.df$datetime, sub.df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(sub.df$datetime, sub.df$Sub_metering_2, col="red")
lines(sub.df$datetime, sub.df$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
       col=c("black", "red", "blue"))

sub.df$Global_reactive_power = as.numeric(as.character(sub.df$Global_reactive_power))
plot(sub.df$datetime, sub.df$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")
dev.off()