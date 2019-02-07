library(readxl)
library(flipTime)
library(dplyr)
library(TTR)

#Data Retrieved from: "https://www.histdata.com/download-free-forex-data/"

EURUSD2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURUSD2018.xlsx")
EURJPY2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURJPY2018.xlsx")

EURUSD2018$Time <- AsDateTime(EURUSD2018$Time)
EURJPY2018$Time <- AsDateTime(EURJPY2018$Time)

#Join the two Datasets
dplr <- left_join(EURUSD2018, EURJPY2018, by=c("Time"))

#Simple MOving Average using past 100 observations
sma_EURUSD <- SMA(EURUSD2018$Open,n=100)

#Aroon Indicator using last 140 observations
aroon_EURUSD <- aroon(dplr[,c("High.x","Low.x")],n=140)

#Bollinger Bands using 20-period SMA
bbands.EURUSD <- BBands(dplr[,c("High.x","Low.x","Close.x")],n=20)


plot(dplr$Time,dplr$Open.x,type = "l")
lines(dplr$Time,sma_EURUSD,col = "green")


plot(dplr$Time,dplr$Open.x,type = "l",xlim=c(as.POSIXct('2018-08-29 19:30:00', 
                                    format="%Y-%m-%d %H:%M:%S"),as.POSIXct('2018-08-30 19:00:00',
                                    format="%Y-%m-%d %H:%M:%S")),ylim = c(1.164,1.172))
lines(dplr$Time,sma_EURUSD,col = "green")


plot(dplr$Time,dplr$Open.x,type = "l",xlim=c(as.POSIXct('2018-08-29 17:00:00', 
                                    format="%Y-%m-%d %H:%M:%S"),as.POSIXct('2018-08-29 23:00:00',
                                    format="%Y-%m-%d %H:%M:%S")),ylim = c(1.168,1.172))
lines(dplr$Time,sma_EURUSD,col = "green")
lines(dplr$Time,bbands.EURUSD[,1],col = "red")
lines(dplr$Time,bbands.EURUSD[,2],col = "blue")
lines(dplr$Time,bbands.EURUSD[,3],col = "purple")
