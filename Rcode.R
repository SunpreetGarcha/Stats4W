library(readxl)
library(flipTime)
library(dplyr)

EURUSD2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURUSD2018.xlsx")
EURJPY2018 <- read_excel("C:/Users/sunpr/Desktop/Stats 4WW3/EURJPY2018.xlsx")

EURUSD2018$Time <- AsDateTime(EURUSD2018$Time)
EURJPY2018$Time <- AsDateTime(EURJPY2018$Time)

plot(EURUSD2018$Time,EURUSD2018$Open,type = "l")
plot(EURJPY2018$Time,EURJPY2018$Open,type = "l")

dplr <- left_join(EURUSD2018, EURJPY2018, by=c("Time"))
plot(dplr$Time,dplr$Open.x,type = "l",ylim = c(1.12,130))
lines(dplr$Time,dplr$Open.y)
