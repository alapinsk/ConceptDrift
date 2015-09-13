#Plot airlines dataset

library(foreign)
airlinesDS <- read.arff("../../moa/realDatasets/airlines.arff")
classCount <- table(airlinesDS$Delay)
baselineAccuracy = classCount[1]/(classCount[2]+classCount[1])
library(caret)
library(mlbench)
library(rJava)
library(Deducer)

require(lattice)
require(ggplot2)

first10000 <- airlinesDS[1:1000,]

#nswprices
first10000$ <- as.numeric(rownames(first10000))

first10000$Airline <- as.numeric(first10000$Airline)
first10000$AirportFrom <- as.numeric(first10000$AirportFrom)
first10000$AirportTo <- as.numeric(first10000$AirportTo)
first10000$DayOfWeek <- as.numeric(first10000$DayOfWeek)


ggplot(first10000, aes(y = Length, x = Time)) + 
  geom_point(aes(colour= Delay, shape= Delay), size = 3, alpha = .8) 


corr.mat<-cor.matrix(variables=d(Airline, Flight, AirportFrom, AirportTo, DayOfWeek, Time, Length),,
                     data=first10000,
                     test=cor.test,
                     method='kendall',
                     alternative="two.sided")

ggcorplot(cor.mat=corr.mat,data=first10000,type="bins",
           cor_text_limits=c(5,15),
           lines=FALSE)


pairs(first10000[1:7], 
      main="Simple Scatterplot Matrix")


#p1 <- ggcorplot(cor.mat=corr.mat,data=diamonds,type="bins",
#                cor_text_limits=c(5,15),
#                lines=FALSE)
#print(p1)