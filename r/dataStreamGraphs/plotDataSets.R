library(foreign)
elecDS <- read.arff("../../moa/realDatasets/elecNormNew.arff")

library(caret)
library(mlbench)
regVar <- c("vicprice")
#get subset of set

randomSample <- elecDS[sample(1:nrow(elecDS), 10000,replace=FALSE), ]

classCount <- table(elecDS$class)
baselineAccuracy = classCount["DOWN"]/(classCount["DOWN"]+classCount["UP"])
elecDS$vicprice <- NULL
elecDS$vicdemand <- NULL
elecDS$transfer <- NULL
elecDS$logNSWprice <- NULL
elecDS$time <- NULL

write.arff(elecDS, "elecDSnswOnly.arff")
####
#PLOTING
####


#nswprices
elecDS$time <- as.numeric(rownames(elecDS))

ggplot(elecDS, aes(y = nswprice, x = time)) + 
  geom_point(aes(colour= class, shape= class), size = 3, alpha = .8) 

#nswprices - hist
ggplot(elecDS, aes(x = nswprice)) + 
  geom_histogram(binwidth = 0.01)

elecDS$logNSWprice = log(elecDS$nswprice)
elecDS$nswprice <- NULL
elecDS <- elecDS[c("logNSWprice","nswdemand", "class")]
write.arff(elecDS, "elecDSnswOnlyLogPrice.arff")

#lognswprices - hist
ggplot(elecDS, aes(x = logNSWprice)) + 
   geom_histogram(binwidth = 0.01)


#nswdemand
ggplot(elecDS, aes(y = nswdemand, x = time)) + 
  geom_point(aes(colour= class, shape= class), size = 3, alpha = .8) 

#nswdemand - boxplot
ggplot(elecDS, aes(y = nswdemand, x = class)) + 
  geom_boxplot(aes(fill = factor(class)))

#nswdemand - hist
ggplot(elecDS, aes(x = nswdemand)) + 
  geom_histogram(binwidth = 0.01)

elecDS$logNSWdemand <- NULL

#lognswdemand - hist
ggplot(elecDS, aes(x = logNSWdemand)) + 
  geom_histogram(binwidth = 0.01)

#vicprices
ggplot(elecDS, aes(y = transfer, x = time)) + 
  geom_point(aes(colour= class, shape= class), size = 3, alpha = .8) 


featurePlot(x=iris[, 1:3], y=iris[,5], plot="scatter")

library(hexbin)
ggplot (randomSample, aes (x = Sepal.Length, y = Sepal.Width, fill = Species)) + 
  stat_binhex (bins=5, aes (alpha = ..count..)) + facet_grid (. ~ Species)


first2500 <- elecDS[1:40000,]
first2500$time <- as.numeric(rownames(first2500))
first2500$nswprice <- first2500$nswprice*1000
ggplot(first2500, aes(y = nswprice, x = time)) + 
  geom_point(aes(colour= class, shape= class), size = 3, alpha = .8) 



###################################################
# save to arff


#write.
  