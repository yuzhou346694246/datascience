pd = read.csv2('/Users/dongge/Downloads/household_power_consumption.txt',sep=";",as.is = T)
pd$Date = as.Date(pd$Date,"%d/%m/%Y")
pd$Voltage = as.numeric(pd$Voltage)
pd$Global_active_power = as.numeric(pd$Global_active_power)
pd$Global_reactive_power = as.numeric(pd$Global_reactive_power)
pd$Global_intensity = as.numeric(pd$Global_intensity)
#pd2017020102 = subset(pd,Date == '2007-2-1' |Date == '2007-2-2')
ppd$Datetime = strptime(paste(as.character(pd$Date),pd$Time), "%Y-%m-%d %H:%M:%S")
pd1 = subset(pd,Datetime >= '2007-2-1' & Datetime <'2007-2-3')
par(mfrow = c(2,2))
par(family='STKaiti')
time <- pd1$Datetime
r <- as.POSIXct(round(range(time), "hours"))
#########
with(pd1,plot(Datetime,Global_active_power,type = 'l',xaxt = 'n',ylab="Global Active Power (kilowatts)",xlab = ""))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day") ,format = "%a")
#########
with(pd1,plot(Datetime,Voltage,type = 'l',xaxt = 'n',ylim = c(230,250)))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day") ,format = "%a")
########
with(pd1,plot(Datetime,Sub_metering_1,type = 'l',xaxt='n',ylab = 'Energy sub metering',xlab = ""))
lines(pd1$Datetime, pd1$Sub_metering_2, col = "blue") 
with(pd1,lines(pd1$Datetime,pd1$Sub_metering_3,col = "red"))
legend("topright",col=c('black','blue','red'),legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty = 1,
        xjust = 1, yjust = 1,
       text.width = strwidth("1,000,000"),
       cex = 0.1)
axis.POSIXct(1, at = seq(r[1], r[2], by = "day") ,format = "%a")
########
with(pd1,plot(Datetime,Global_reactive_power,type = 'l',xaxt = 'n'))
axis.POSIXct(1, at = seq(r[1], r[2], by = "day") ,format = "%a")
dev.copy(png,'plot4.png')
dev.off()