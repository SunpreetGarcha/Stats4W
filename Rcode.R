library(readxl)
library(flipTime)
library(dplyr)
library(TTR)

EURUSD2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURUSD2018.xlsx")
EURJPY2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURJPY2018.xlsx")

EURUSD2018$Time <- AsDateTime(EURUSD2018$Time)
EURJPY2018$Time <- AsDateTime(EURJPY2018$Time)

plot(EURUSD2018$Time,EURUSD2018$Open,type = "l")
plot(EURJPY2018$Time,EURJPY2018$Open,type = "l")

sma_EURUSD <- SMA(EURUSD2018$Open,n=100)

dplr <- left_join(EURUSD2018, EURJPY2018, by=c("Time"))
plot(dplr$Time,dplr$Open.x,type = "l")
lines(dplr$Time,sma_EURUSD,col = "green")


plot(dplr$Time,dplr$Open.x,type = "l",xlim=c(as.POSIXct('2018-08-29 19:30:00', 
                                    format="%Y-%m-%d %H:%M:%S"),as.POSIXct('2018-08-30 19:00:00',
                                    format="%Y-%m-%d %H:%M:%S")),ylim = c(1.164,1.172))
lines(dplr$Time,sma_EURUSD,col = "green")

