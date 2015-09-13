library(ggplot2)
library(RColorBrewer) 
library(grid)
library(ggthemes)

#Plotting

inPath  <- "../workspace/output/csv/hyperplane/"
outPath <- "plots/stagger/"
outExtension <- ".png"



files <- list.files(pattern = "\\.csv$", path = inPath)

meanAue        <- 0
meanAWE        <- 0
meanAue20      <- 0
meanAWE20      <- 0
meanHT         <- 0
meanHTAdwin    <- 0
meanHTEddm     <- 0
meanLevBag     <- 0
meanNaiveBayes <- 0
meanNoChange   <- 0

meanEnsADE     <- 0
meanEnsSAE     <- 0
meanEnsSAEmax  <- 0
meanEnsSAEmin  <- 0
meanEnsSDE     <- 0
meanHtSTEPD    <- 0


keeps <- c("learning.evaluation.instances", "classifications.correct..percent.", "Kappa.Statistic..percent.", 
           "Kappa.Temporal.Statistic..percent.", "model.cost..RAM.Hours.")

for (input in files){
  output <- basename(file.path(input,fsep=".csv")) 
  graph  <- read.csv(paste0(inPath, input), sep= ",", header = T, fileEncoding="UTF-16LE")
  
  
  if(output == "noChange.csv")
  {
    noChange <- graph
    meanNoChange <- mean(noChange$classifications.correct..percent.)
    noChange <- noChange[keeps]
    noChange$classifier = "No-Change"
    
    
    noChange$Kappa.Statistic..percent. <- gsub("?",0,noChange$Kappa.Statistic..percent., fixed = TRUE)
    noChange$Kappa.Temporal.Statistic..percent. <- gsub("?",0,noChange$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    noChange$Kappa.Statistic..percent. <- as.numeric(noChange$Kappa.Statistic..percent.) 
    noChange$Kappa.Temporal.Statistic..percent. <- as.numeric(noChange$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "aue.csv")
  {
    aue <- graph
    meanAue <- mean(aue$classifications.correct..percent.)
    aue <- aue[keeps]
    aue$classifier = "AUE500"
    
    aue$Kappa.Statistic..percent. <- gsub("?",0,aue$Kappa.Statistic..percent., fixed = TRUE)
    aue$Kappa.Temporal.Statistic..percent. <- gsub("?",0,aue$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    aue$Kappa.Statistic..percent. <- as.numeric(aue$Kappa.Statistic..percent.) 
    aue$Kappa.Temporal.Statistic..percent. <- as.numeric(aue$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "awe.csv")
  {
    awe <- graph
    meanAWE <- mean(awe$classifications.correct..percent.)
    awe <- awe[keeps]
    awe$classifier = "AWE500"
    
    awe$Kappa.Statistic..percent. <- gsub("?",0,awe$Kappa.Statistic..percent., fixed = TRUE)
    awe$Kappa.Temporal.Statistic..percent. <- gsub("?",0,awe$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    awe$Kappa.Statistic..percent. <- as.numeric(awe$Kappa.Statistic..percent.) 
    awe$Kappa.Temporal.Statistic..percent. <- as.numeric(awe$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "aue20.csv")
  {
    aue20 <- graph
    meanAue20 <- mean(aue20$classifications.correct..percent.)
    aue20 <- aue20[keeps]
    aue20$classifier = "AUE20"
    
    aue20$Kappa.Statistic..percent. <- gsub("?",0,aue20$Kappa.Statistic..percent., fixed = TRUE)
    aue20$Kappa.Temporal.Statistic..percent. <- gsub("?",0,aue20$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    aue20$Kappa.Statistic..percent. <- as.numeric(aue20$Kappa.Statistic..percent.) 
    aue20$Kappa.Temporal.Statistic..percent. <- as.numeric(aue20$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "awe20.csv")
  {
    awe20 <- graph
    meanAWE20 <- mean(awe20$classifications.correct..percent.)
    awe20 <- awe20[keeps]
    awe20$classifier = "AWE20"
    
    awe20$Kappa.Statistic..percent. <- gsub("?",0,awe20$Kappa.Statistic..percent., fixed = TRUE)
    awe20$Kappa.Temporal.Statistic..percent. <- gsub("?",0,awe20$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    awe20$Kappa.Statistic..percent. <- as.numeric(awe20$Kappa.Statistic..percent.) 
    awe20$Kappa.Temporal.Statistic..percent. <- as.numeric(awe20$Kappa.Temporal.Statistic..percent.)
  }
  else if(output == "hT.csv")
  {
    hT <- graph
    meanHT  <- mean(hT$classifications.correct..percent.)
    hT <- hT[keeps]
    hT$classifier = "HoeffdingTree"
    
    hT$Kappa.Statistic..percent. <- gsub("?",0,hT$Kappa.Statistic..percent., fixed = TRUE)
    hT$Kappa.Temporal.Statistic..percent. <- gsub("?",0,hT$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    hT$Kappa.Statistic..percent. <- as.numeric(hT$Kappa.Statistic..percent.) 
    hT$Kappa.Temporal.Statistic..percent. <- as.numeric(hT$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "hTADWIN.csv")
  {
    htADWIN <- graph
    meanHTAdwin <- mean(htADWIN$classifications.correct..percent.)
    htADWIN <- htADWIN[keeps]
    htADWIN$classifier = "HT + ADWIN"
    
    htADWIN$Kappa.Statistic..percent. <- gsub("?",0,htADWIN$Kappa.Statistic..percent., fixed = TRUE)
    htADWIN$Kappa.Temporal.Statistic..percent. <- gsub("?",0,htADWIN$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    htADWIN$Kappa.Statistic..percent. <- as.numeric(htADWIN$Kappa.Statistic..percent.) 
    htADWIN$Kappa.Temporal.Statistic..percent. <- as.numeric(htADWIN$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "hTeddm.csv")
  {
    hTeddm <- graph
    meanHTEddm <- mean(hTeddm$classifications.correct..percent.)
    hTeddm <- hTeddm[keeps]
    hTeddm$classifier = "HT + EDDM"
    
    hTeddm$Kappa.Statistic..percent. <- gsub("?",0,hTeddm$Kappa.Statistic..percent., fixed = TRUE)
    hTeddm$Kappa.Temporal.Statistic..percent. <- gsub("?",0,hTeddm$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    hTeddm$Kappa.Statistic..percent. <- as.numeric(hTeddm$Kappa.Statistic..percent.) 
    hTeddm$Kappa.Temporal.Statistic..percent. <- as.numeric(hTeddm$Kappa.Temporal.Statistic..percent.)
  }
  else if(output == "levBag.csv")
  {
    levBag <- graph
    meanLevBag <- mean(levBag$classifications.correct..percent.)
    levBag <- levBag[keeps]
    levBag$classifier = "LeveragingBag"
    
    levBag$Kappa.Statistic..percent. <- gsub("?",0,levBag$Kappa.Statistic..percent., fixed = TRUE)
    levBag$Kappa.Temporal.Statistic..percent. <- gsub("?",0,levBag$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    levBag$Kappa.Statistic..percent. <- as.numeric(levBag$Kappa.Statistic..percent.) 
    levBag$Kappa.Temporal.Statistic..percent. <- as.numeric(levBag$Kappa.Temporal.Statistic..percent.) 
    
  }
  else if(output == "naiveBayes.csv")
  {
    naiveBayes <- graph
    meanNaiveBayes <- mean(naiveBayes$classifications.correct..percent.)
    naiveBayes <- naiveBayes[keeps]
    naiveBayes$classifier = "Naive Bayes"
    
    naiveBayes$Kappa.Statistic..percent. <- gsub("?",0,naiveBayes$Kappa.Statistic..percent., fixed = TRUE)
    naiveBayes$Kappa.Temporal.Statistic..percent. <- gsub("?",0,naiveBayes$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    naiveBayes$Kappa.Statistic..percent. <- as.numeric(naiveBayes$Kappa.Statistic..percent.) 
    naiveBayes$Kappa.Temporal.Statistic..percent. <- as.numeric(naiveBayes$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "ensADE.csv")
  {
    ensADE <- graph
    meanEnsADE     <- mean(ensADE$classifications.correct..percent.)
    ensADE <- ensADE[keeps]
    ensADE$classifier = "HT+ADEmaj"
    
    ensADE$Kappa.Statistic..percent. <- gsub("?",0,ensADE$Kappa.Statistic..percent., fixed = TRUE)
    ensADE$Kappa.Temporal.Statistic..percent. <- gsub("?",0,ensADE$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    ensADE$Kappa.Statistic..percent. <- as.numeric(ensADE$Kappa.Statistic..percent.) 
    ensADE$Kappa.Temporal.Statistic..percent. <- as.numeric(ensADE$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "ensSAE.csv")
  {
    ensSAE <- graph
    meanEnsSAE     <- mean(ensSAE$classifications.correct..percent.)
    ensSAE <- ensSAE[keeps]
    ensSAE$classifier = "HT+SAEmaj"
    
    ensSAE$Kappa.Statistic..percent. <- gsub("?",0,ensSAE$Kappa.Statistic..percent., fixed = TRUE)
    ensSAE$Kappa.Temporal.Statistic..percent. <- gsub("?",0,ensSAE$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    ensSAE$Kappa.Statistic..percent. <- as.numeric(ensSAE$Kappa.Statistic..percent.) 
    ensSAE$Kappa.Temporal.Statistic..percent. <- as.numeric(ensSAE$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "ensSAEmax.csv")
  {
    ensSAEmax <- graph
    meanEnsSAEmax  <- mean(ensSAEmax$classifications.correct..percent.)
    ensSAEmax <- ensSAEmax[keeps]
    ensSAEmax$classifier = "HT+SAEmax"
    
    ensSAEmax$Kappa.Statistic..percent. <- gsub("?",0,ensSAEmax$Kappa.Statistic..percent., fixed = TRUE)
    ensSAEmax$Kappa.Temporal.Statistic..percent. <- gsub("?",0,ensSAEmax$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    ensSAEmax$Kappa.Statistic..percent. <- as.numeric(ensSAEmax$Kappa.Statistic..percent.) 
    ensSAEmax$Kappa.Temporal.Statistic..percent. <- as.numeric(ensSAEmax$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "ensSAEmin.csv")
  {
    ensSAEmin <- graph
    meanEnsSAEmin  <- mean(ensSAEmin$classifications.correct..percent.)
    ensSAEmin <- ensSAEmin[keeps]
    ensSAEmin$classifier = "HT+SAEmin"
    
    ensSAEmin$Kappa.Statistic..percent. <- gsub("?",0,ensSAEmin$Kappa.Statistic..percent., fixed = TRUE)
    ensSAEmin$Kappa.Temporal.Statistic..percent. <- gsub("?",0,ensSAEmin$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    ensSAEmin$Kappa.Statistic..percent. <- as.numeric(ensSAEmin$Kappa.Statistic..percent.) 
    ensSAEmin$Kappa.Temporal.Statistic..percent. <- as.numeric(ensSAEmin$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "ensSDE.csv")
  {
    ensSDE <- graph
    meanEnsSDE     <- mean(ensSDE$classifications.correct..percent.)
    ensSDE <- ensSDE[keeps]
    ensSDE$classifier = "HT+SDEmaj"
    
    ensSDE$Kappa.Statistic..percent. <- gsub("?",0,ensSDE$Kappa.Statistic..percent., fixed = TRUE)
    ensSDE$Kappa.Temporal.Statistic..percent. <- gsub("?",0,ensSDE$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    ensSDE$Kappa.Statistic..percent. <- as.numeric(ensSDE$Kappa.Statistic..percent.) 
    ensSDE$Kappa.Temporal.Statistic..percent. <- as.numeric(ensSDE$Kappa.Temporal.Statistic..percent.) 
  }
  else if(output == "htSTEPD.csv")
  {
    htSTEPD <- graph
    meanHtSTEPD    <- mean(htSTEPD$classifications.correct..percent.)
    htSTEPD <- htSTEPD[keeps]
    htSTEPD$classifier = "HT+STEPD"
    
    htSTEPD$Kappa.Statistic..percent. <- gsub("?",0,htSTEPD$Kappa.Statistic..percent., fixed = TRUE)
    htSTEPD$Kappa.Temporal.Statistic..percent. <- gsub("?",0,htSTEPD$Kappa.Temporal.Statistic..percent., fixed = TRUE)
    
    htSTEPD$Kappa.Statistic..percent. <- as.numeric(htSTEPD$Kappa.Statistic..percent.) 
    htSTEPD$Kappa.Temporal.Statistic..percent. <- as.numeric(htSTEPD$Kappa.Temporal.Statistic..percent.) 
  }
} 