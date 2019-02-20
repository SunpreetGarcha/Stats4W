library(readxl)
# require(devtools)
# install_github("Displayr/flipTime")
library(flipTime)
library(dplyr)
library(TTR)
library(here)
library(forecast)

#Data Retrieved from: "https://www.histdata.com/download-free-forex-data/"

EURUSD2018 <- read_excel(here("EURUSD2018.xlsx"))


EURUSD2018$Time <- AsDateTime(EURUSD2018$Time)

#Simple Moving Average using past 100 observations
sma_EURUSD <- data.frame(SMA(EURUSD2018$Open,n=100))
sma_EURUSD <- cbind(sma_EURUSD,EURUSD2018$Time)
colnames(sma_EURUSD)[1] <- "SMA(100)"
colnames(sma_EURUSD)[2] <- "Time"

#Join the two Datasets
data <- inner_join(EURUSD2018, sma_EURUSD)

#Simple Moving Average using past 40 observations
sma40_EURUSD <- data.frame(SMA(EURUSD2018$Open,n=40))
sma40_EURUSD <- cbind(sma40_EURUSD,EURUSD2018$Time)
colnames(sma40_EURUSD)[1] <- "SMA(40)"
colnames(sma40_EURUSD)[2] <- "Time"

#Join the two Datasets
data <- inner_join(data, sma40_EURUSD)

#Bollinger Bands using 20-period SMA 
bbands_EURUSD <- data.frame(BBands(data[,c("High","Low","Close")],n=20))
bbands_EURUSD <- cbind(bbands_EURUSD,EURUSD2018$Time)
colnames(bbands_EURUSD)[5] <- "Time"

#Join the two Datasets
data <- inner_join(data, bbands_EURUSD)

#Relative Strength Index using past 20 periods
rsi_EURUSD <- data.frame(RSI(data$Open,n=20))
rsi_EURUSD <- cbind(rsi_EURUSD,EURUSD2018$Time)
colnames(rsi_EURUSD)[1] <- "RSI"
colnames(rsi_EURUSD)[2] <- "Time"

#Join the two Datasets
data <- inner_join(data, rsi_EURUSD)

#Some Plots
plot(data$Time,data$Open,type = "l")
lines(data$Time,data$`SMA(100)`,col = "green")
lines(data$Time,data$dn,col = "red")
lines(data$Time,data$mavg,col = "blue")
lines(data$Time,data$up,col = "purple")


plot(data$Time,data$Open,type = "l",xlim=c(as.POSIXct('2018-08-29 19:30:00', 
                                    format="%Y-%m-%d %H:%M:%S"),as.POSIXct('2018-08-30 19:00:00',
                                    format="%Y-%m-%d %H:%M:%S")),ylim = c(1.164,1.172))
lines(data$Time,data$`SMA(100)`,col = "green")
lines(data$Time,data$dn,col = "red")
lines(data$Time,data$mavg,col = "blue")
lines(data$Time,data$up,col = "purple")

plot(data$Time,data$Open,type = "l",xlim=c(as.POSIXct('2018-08-29 17:00:00', 
                                    format="%Y-%m-%d %H:%M:%S"),as.POSIXct('2018-08-29 23:00:00',
                                    format="%Y-%m-%d %H:%M:%S")),ylim = c(1.168,1.172))
lines(data$Time,data$'SMA(100)',col = "green")
lines(data$Time,data$dn,col = "red")
lines(data$Time,data$mavg,col = "blue")
lines(data$Time,data$up,col = "purple")

#Trying out recommended forecast package
#fc <- forecast(data$Open)
#plot(fc)
#View(fc)
#summary(fc)
#Takes a while to run and I don't entirely understand it yet
#Will be trying to read Rob Hyndman's book to understand







