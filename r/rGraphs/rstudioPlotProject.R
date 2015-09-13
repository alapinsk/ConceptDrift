library(ggplot2)
inPath  <- "csv/"
outPath <- "plots/"
outExtension <- ".png"



files <- list.files(pattern = "\\.csv$", path = inPath)


for (input in files){
  output <- basename(file.path(input,fsep=".csv")) 
  graph  <- read.csv(paste0("csv/", input), sep= ",", header = T, fileEncoding="UTF-16LE")
  
  q <- ggplot(graph, aes(learning.evaluation.instances, classifications.correct..percent.)) +
        geom_line(aes(colour = Kappa.Temporal.Statistic..percent.), size=0.5) + scale_colour_gradient(low="red") +
        scale_x_continuous(breaks = round(seq(min(graph$learning.evaluation.instances), 
                                              max(graph$learning.evaluation.instances), by = 5000),1)) +
        scale_y_continuous(breaks = round(seq(min(graph$classifications.correct..percent.), 
                                              max(graph$classifications.correct..percent.), by = 10),1)) 
        #theme_bw() +
        #theme(axis.title=element_text(face="bold.italic", size="12", color="brown"), legend.position="top")
    
    
  
  ggsave(q, file=paste0(outPath, "output for ", input, outExtension),
         width = 8, height = 6)
} 

