#This R script concatenates all results from viral seq2species runs across all samples, and outputs them to a singly Excel file.

library(ggplot2); library(reshape2); library(data.table); library(rio)

args = commandArgs(trailingOnly=TRUE)                                                                                                                     
# test if there is at least one argument: if not, return an error                                                                                         
if (length(args)==0) {                                                                                                                                    
    stop("Please provide the starting PIVUS sample and the ending PIVUS sample representing the range of samples for this to be run on.", call.=FALSE)                                                                             
}                                                                                                                                                         

startSample=args[1]
endSample=args[2]

sample=startSample
convert(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.tsv", sep=""), paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""))
viralreads=data.frame(readxl::read_xlsx(path =paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep = ""), col_names = T), check.names = F)
viralreads=cbind(c(sample),viralreads)
while(sample != endSample) { # loop includes endSample
  sample=substring(sample, 6)
  sample=as.numeric(sample)
  sample=sample+1
  sample=sprintf("PIVUS%03d", sample)
  print(sample)
  convert(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.tsv", sep=""), paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep=""))
  if(nrow(data.frame(readxl::read_xlsx(path =paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep = ""), col_names = T), check.names = F)) > 1){
    nviralreads=cbind(c(sample),data.frame(readxl::read_xlsx(path =paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/",sample,"_viral-sequence-to-species.out.xlsx", sep = ""), col_names = T), check.names = F))
    viralreads=rbind(viralreads, nviralreads)
  } else {
    print("This sample was empty or incomplete.")
  }
}
write.csv(viralreads, file = "/users/j29tien/ROP/results/VIRAL/cross-sample-viral-seq2species.csv")
