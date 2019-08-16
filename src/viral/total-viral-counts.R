
args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error                              
if (length(args)==0) {
  stop("Please provide the starting and ending PIVUS samples representing the range for this to be run on.", call.=FALSE)                                          
}
startSample=args[1]
endSample=args[2]
sample=startSample

totalviralcount <- read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv", sep=""))
ROPmapped_readcount <- rowSums(totalviralcount)
totalviralcount <- totalviralcount[c(1)]

#will be making this a proportion of all the reads ROP was able to map
pviral <- totalviralcount/ROPmapped_readcount

totalviralcount <- cbind(sample,totalviralcount, ROPmapped_readcount, pviral)
while(sample != endSample) { # loop includes endSample                                         
  sample=substring(sample, 6)
  sample=as.numeric(sample)
  sample=sample+1
  sample=sprintf("PIVUS%03d", sample)
  print(sample)

  if(file.exists(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv", sep=""))) {
    next_entry = read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/",sample,"_Aligned--counts.csv", sep=""))
    ROPmapped_readcount <- rowSums(next_entry)
    next_entry <- next_entry[c(1)]
    pviral <- next_entry/ROPmapped_readcount
    next_entry <- cbind(sample, next_entry, ROPmapped_readcount, pviral)
    totalviralcount <- rbind(totalviralcount,next_entry)
  }

}

colnames(totalviralcount) <- c("Sample","Viral Read Count", "ROP Mapped Read Count", "Proportion")
write.csv(totalviralcount, file="/users/j29tien/ROP/results/VIRAL/total-viral-count.csv")
#if(NROW(next_entry) > 1) {
  age_seventy <- subset(totalviralcount, as.numeric(substring(totalviralcount$Sample,6)) %% 2 == 1 & totalviralcount$Sample != "PIVUS039",select=c("Sample", "Viral Read Count", "ROP Mapped Read Count", "Proportion")) 
  age_eighty <- subset(totalviralcount, as.numeric(substring(totalviralcount$Sample,6)) %% 2 == 0,select=c("Sample", "Viral Read Count", "ROP Mapped Read Count", "Proportion"))
  seventy_eighty_count <- cbind(age_seventy[c("Viral Read Count")], age_eighty[c("Viral Read Count")])
  p_seventy_eighty <- cbind(age_seventy[c("Proportion")], age_eighty[c("Proportion")])
  colnames(seventy_eighty_count) <- c("Age 70", "Age 80")
  colnames(p_seventy_eighty) <- c("Age 70", "Age 80")
  write.csv(seventy_eighty_count, file="/users/j29tien/ROP/results/VIRAL/viral-count-by-age.csv")
  write.csv(p_seventy_eighty, file="/users/j29tien/ROP/results/VIRAL/viral-proportion-by-age.csv")
#}

