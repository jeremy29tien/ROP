# This R script creates a summary of the results of the ROP run (breakdown of counts of each different type of unmapped read).

library(ggplot2); library(reshape2); library(data.table); library(rio)

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error                                                                                         
if (length(args)==0) {
    stop("Please provide the starting PIVUS sample and the ending PIVUS sample representing the range of samples for this to be run on.", call.=FALSE)
}

startSample=args[1]
endSample=args[2]

sample=startSample
summaryTable = read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv",sep=""))
summaryTable <- cbind(sample, summaryTable)
#colnames(summaryTable) <- "Viral", "Repeats", "rDNA",
while(sample != endSample) { # loop includes endSample
  sample=substring(sample, 6)
  sample=as.numeric(sample)
  sample=sample+1
  sample=sprintf("PIVUS%03d", sample)
  print(sample)
  if(file.exists(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv", sep="")))
  {
    summaryTable <- rbind(summaryTable,cbind(sample,read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv", sep=""))))
  }
}

write.csv(summaryTable, file="/users/j29tien/ROP/results/ROP_SUMMARY.csv")
