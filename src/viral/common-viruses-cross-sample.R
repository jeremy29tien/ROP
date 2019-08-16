library(ggplot2); library(reshape2); library(data.table)

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("Please provide the starting and ending PIVUS samples representing the range for this to be run on.", call.=FALSE)
}
startSample=args[1]
endSample=args[2]
sample=startSample

viral_tops_consolidated <- read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/", sample,"_viral-read-counts-by-species.csv", sep=""))
viral_tops_consolidated <- viral_tops_consolidated[c(2,3)] #removes first column (just old row indexes)
#Can change below from top 20 to top 10 or top 5 
viral_tops <- viral_tops_consolidated[1:20,]
colnames(viral_tops) <- c("Organism", "Read Count")

while(sample != endSample) { # loop includes endSample
  sample=substring(sample, 6)
  sample=as.numeric(sample)
  sample=sample+1
  sample=sprintf("PIVUS%03d", sample)
  print(sample)
  
  next_file <- read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/", sample,"_viral-read-counts-by-species.csv", sep=""))
  if(NROW(next_file) > 1) {  
    next_file <- next_file[c(2,3)]
    #Can change below from top 20 to top 10 or top 5
    next_tops <- next_file[1:20,]
    colnames(next_tops) <- c("Organism", "Read Count")
  
    #merge individual sample-files
    viral_tops_consolidated <- data.table(rbind(viral_tops, next_tops))
    viral_tops_consolidated <- viral_tops_consolidated[, lapply(.SD, sum), by=list(viral_tops_consolidated$Organism)]
    viral_tops_consolidated <- as.data.frame(viral_tops_consolidated)
    colnames(viral_tops_consolidated) <- c("Organism", "Read Count")
  }
}
write.csv(viral_tops_consolidated, file="/users/j29tien/ROP/results/VIRAL/common-viruses_top20.csv") 
