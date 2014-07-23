	
	# Check if the file exist, if not download
	if (!file.exists("household_power_consumption.txt")) {
		url<- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		download.file(url,"assignment1.zip")
		unzip("assignment1.zip")
	} 

	#library(sqldf)
	#data <- read.csv2.sql("household_power_consumption.txt","SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'")
	
	# The below two lines are specifically written for WINDOWS environment, the above commented lines would work for both
	# WINDOWS and unix, but they are slow, so for WINDOWS the best solution is use findstr, if we uncomment the above 2 lines
	# the below 2 lines should be commented so that code runs properly
	
	data <- read.table(pipe('findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt'),header=F, sep=';',stringsAsFactors = FALSE,na.strings ="?")
	colnames(data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))
	
	data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
	
	png(filename = "plot3.png", width = 480, height = 480, units = "px")
	
	with(data,{
		plot(data$Time,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering", col = "black")
		lines(data$Time,data$Sub_metering_2,col = "red")
		lines(data$Time,data$Sub_metering_3,col = "blue")
		legend("topright" , 
        c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"), 
        lty=1, 
        bty="o",col=c("black", "red","blue")) 
	})
		
	dev.off()