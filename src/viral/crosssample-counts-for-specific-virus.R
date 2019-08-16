# This script will be run on the viruses that have appeared in the top 20 of at least one of the samples. This script will create a file displaying sample and viral read count for a specific virus (ie. Herpes, etc.)                                                                      
#For future: can make this more efficient by writing a script that goes through the top20s all at once, writing each virus to its own file (eliminates need to search).                       

args = commandArgs(trailingOnly=TRUE)                                                          
# test if there is at least one argument: if not, return an error                              
if (length(args)==0) {
  stop("Please provide the starting and ending PIVUS samples representing the range for this to be run on.", call.=FALSE)                                                                     
}                                                                                              
startSample=args[1]                                                                            
endSample=args[2]                                                                              
virus=args[3]
sample=startSample                                                                            
 

viralreadcounts = read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/", sample,"_viral-read-counts-by-species.csv", sep=""))                     
viralreadcounts <- viralreadcounts[c(2,3)]
ROPmapped_counts <- read.csv("/users/j29tien/ROP/results/VIRAL/total-viral-count.csv")
allROPreads <- ROPmapped_counts[which(ROPmapped_counts$Sample == sample), ][c("ROP.Mapped.Read.Count")]
#colnames(viralreadcounts) <- c("Organism", "Read Count")
specified_virus <- viralreadcounts[which(viralreadcounts$Organism == virus), ]
specified_virus <- cbind(sample, specified_virus, specified_virus[c("Read.Count")]/allROPreads)

while(sample != endSample) { # loop includes endSample                                         
  sample=substring(sample, 6)                                                                  
  sample=as.numeric(sample)                                                                    
  sample=sample+1                                                                              
  sample=sprintf("PIVUS%03d", sample)                                                          
  print(sample)
  
  next_entry = read.csv(paste("/users/j29tien/ROP/results/",sample,"_ROP/07c_viral/", sample,"_viral-read-counts-by-species.csv", sep=""))
  if(NROW(next_entry) > 1) {
    next_entry <- next_entry[c(2,3)]
    allviralreads <- ROPmapped_counts[which(ROPmapped_counts$Sample == sample), ][c("ROP.Mapped.Read.Count")]
    next_entry <- next_entry[which(next_entry$Organism == virus), ]
    next_entry <- cbind(sample, next_entry, next_entry[c("Read.Count")]/allviralreads)
    specified_virus <- rbind(specified_virus,next_entry)
  }
}
filename=tolower(gsub(" ","_",virus))
dir.create(file.path("/users/j29tien/ROP/results/VIRAL/", filename))
#setwd(file.path(mainDir, subDir))
colnames(specified_virus) <- c("Sample", "Organism", "Read Count", "Scaled for total ROP mapped-read count")
write.csv(specified_virus, file=paste("/users/j29tien/ROP/results/VIRAL/",filename,"/", filename,".csv", sep=""))
#if(NROW(next_entry) > 1) {
  age_seventy <- subset(specified_virus, as.numeric(substring(specified_virus$Sample,6)) %% 2 == 1 & specified_virus$Sample != "PIVUS039",select=c("Sample", "Organism", "Read Count", "Scaled for total ROP mapped-read count" ))
  age_eighty <- subset(specified_virus, as.numeric(substring(specified_virus$Sample,6)) %% 2 == 0,select=c("Sample", "Organism", "Read Count", "Scaled for total ROP mapped-read count" ))

  seventy_eighty <- cbind(age_seventy[c("Read Count")], age_eighty[c("Read Count")])
  scaled_seventy_eighty <- cbind(age_seventy[c("Scaled for total ROP mapped-read count")], age_eighty[c("Scaled for total ROP mapped-read count")])
  colnames(seventy_eighty) <- c("Age 70", "Age 80")
  colnames(scaled_seventy_eighty) <- c("Age 70", "Age 80")
  write.csv(seventy_eighty, file=paste("/users/j29tien/ROP/results/VIRAL/",filename,"/70-80_",filename,".csv", sep=""))
  write.csv(scaled_seventy_eighty, file=paste("/users/j29tien/ROP/results/VIRAL/",filename,"/scaled_70-80_", filename,".csv",sep=""))
#}

