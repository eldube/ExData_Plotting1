#########################################Plot3.R SCRIPT######################################
## THIS SCRIPTS PLOTS AND CREATES plot3.png  file. IN THIS SCRIPTS TWO(2) FUNCTIONS ARE    ##
## DEFINED AND USED:                                                                       ##
## 1. readData()    --THIS FUNCTION READS DATA FROM SOURCE FILE AND RETURNS A SUBSET OF    ##
##                    THE DATA REQUIRED TO GENERATE THE PLOT                               ##
## 2. generatePlot()--THIS FUNCTION GENERATES REQUIRED PLOT AND STORES IT IN A .png FILE   ##
##                    THE FILENAME IS GIVEN AS AN ARGUMENT TO THIS FUNCTION                ##
#############################################################################################



######################################### readData() FUNCTION################################
##            THIS FUNCTIONS READS AND SUBSETS THE DATA REQUIRED TO GENERATE THE PLOT      ##
#############################################################################################

readData <- function () {
  
  ## set your working directory --- replace line below with  your exact woking               
  ## directory containing the text file "household_power_consumption.txt"B                   
  setwd ("C:/COURSERAWORK/EXPLOCODE/PROJECT1/")
  
  ## read data from the text file, using read table
  options(StringsAsFactors=F)         ## disable reading of data as factors 
  hpcData <- read.table ("household_power_consumption.txt", sep=";", header = TRUE)
  
  
  ## convert date variable from character() to date()
  hpcData$Date <- as.Date(hpcData$Date, '%d/%m/%Y')
  
  ## subset data for target dates : 2007-02-01 to 2007-02-02
  targetData <<- subset (hpcData, hpcData$Date >= "2007-02-01" & hpcData$Date <= "2007-02-02")
  
  ## NOTE :  <<- operator use to cache variables targetData , and make it available to     
  ##        to the function generatePlot() defined below. 
  
}
################################ END FUNCTION readData() ###################################



######################################### generatePlot(filename) FUNCTION#####################
##THIS FUNCTION USES THE readData() FUNCTION (DEFINED ABOVE) TO READ REQUIRED DATA AND THEN ##
## CREATES THE .png file WHOSE NAME GIVEN AS AN ARGUMENT TO THE FUNCTION                    ##                                                                        ##
##############################################################################################


generatePlot <- function (filename) {
  
  ## Call function readData() to get required data for the plot 
  readData()
  
  ## convert Global_active_power data to numeric.
  targetData$Global_active_power <- as.numeric(as.character(targetData$Global_active_power))
  
  
  ## convert Date to DateTime and format it
  varDateTime <- paste(targetData$Date, targetData$Time, sep = " ") ## Join Date and Time 
  formattedDateTime <- strptime(varDateTime, format="%Y-%m-%d %H:%M:%S") 
 
  
  ## subset data for plot 3
  plot3Data <- data.frame (DateTime =formattedDateTime, 
                           Sub_metering_1 = as.numeric(as.character(targetData$Sub_metering_1)),
                           Sub_metering_2 = as.numeric(as.character(targetData$Sub_metering_2)), 
                           Sub_metering_3= as.numeric(as.character(targetData$Sub_metering_3)) )
  
  
  
  # ## open PNG device and store file in working directory 
  png (file = as.character(filename), width = 480, height = 480, units = "px") 
  
  ##draw plot
  with (plot3Data, plot(DateTime, Sub_metering_1, type="l", xlab= "", ylab= "Energy Sub Metering"))   ## plot first line
  with (plot3Data, lines(DateTime, Sub_metering_2, type="l", col="red"))   ## add second line
  with (plot3Data, lines(DateTime, Sub_metering_3, type="l", col="blue"))  ## add third line
  
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col = c("black","red","blue") )
  
  ## close PNG file device
  dev.off() 
  
  
}
################################ END OF FUNCTION generatePlot() ############################


######################################### GERERATE PLOT######################################
## CALL generatePlot() FUNCTION (define above) TO GENERATE PLOT and save in file plot3.png ##
#############################################################################################

generatePlot("plot3.png")
rm (list = ls())  ## delete objects to release memory

#################################### END OF SCRIPT###########################################

