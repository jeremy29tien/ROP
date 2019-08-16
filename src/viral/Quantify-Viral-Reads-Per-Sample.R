library(ggplot2); library(reshape2); library(data.table); library(rio)

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("Please provide the starting and ending PIVUS samples representing the range for this to be run on.", call.=FALSE)
}
print("Running script to consolidate reads for each organism ...")
startSample=args[1]
endSample=args[2]
sample=startSample
#Load .tsv as a data frame
#need to figure out how to save .tsv as .xlsx
convert(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.tsv", sep=""), paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""))
viralreads=data.frame(readxl::read_xlsx(path =paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""), col_names = T), check.names = F)
#Exclude all entries with Read Count of less than 20
viralreads_filtered = viralreads[viralreads$`Sequence Count`>=20, ]
#Sum Read Counts of same ORGANISM
#https://datascience.stackexchange.com/questions/12026/sum-up-counts-in-a-data-frame-grouped-by-multiple-variables
viralreads_consolidated = xtabs(formula = viralreads_filtered$`Sequence Count`~viralreads_filtered$ORGANISM)
viralreads_consolidated = as.data.frame.table(viralreads_consolidated)
viralreads_sorted = viralreads_consolidated[order(-viralreads_consolidated$Freq),]
if(NROW(viralreads_sorted) > 1) {
    colnames(viralreads_sorted) <- c("Organism", "Read Count")
  }
write.csv(viralreads_sorted, file = paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-read-counts-by-species.csv", sep=""))

while(sample != endSample) { # loop includes endSample
  sample=substring(sample, 6)
  sample=as.numeric(sample)
  sample=sample+1
  sample=sprintf("PIVUS%03d", sample)
  print(sample)
  convert(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.tsv", sep=""), paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""))
  viralreads=data.frame(readxl::read_xlsx(path =paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""), col_names = T), check.names = F)
  #Exclude all entries with Read Count of less than 20
  viralreads_filtered = viralreads[viralreads$`Sequence Count`>=20, ]
  #Sum Read Counts of same ORGANISM
  #https://datascience.stackexchange.com/questions/12026/sum-up-counts-in-a-data-frame-grouped-by-multiple-variables
  viralreads_consolidated = xtabs(formula = viralreads_filtered$`Sequence Count`~viralreads_filtered$ORGANISM)
  viralreads_consolidated = as.data.frame.table(viralreads_consolidated)
  viralreads_sorted = viralreads_consolidated[order(-viralreads_consolidated$Freq),]
  if(NROW(viralreads_sorted) > 1) {  
    colnames(viralreads_sorted) <- c("Organism", "Read Count")
  }
  write.csv(viralreads_sorted, file = paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-read-counts-by-species.csv", sep=""))
}

