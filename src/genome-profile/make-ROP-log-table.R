
if(FALSE){
ROPLogData <- read.csv(file='/users/j29tien/ROP/results/PIVUS003_ROP/PIVUS003_Aligned--counts.csv',sep=',')
#print(summary(ROPLogData))
#print(ROPLogData)

#ROPLog <- table(ROPLogData$X07c_viral,ROPLogData$X04_repeats,ROPLogData$X02_rdna,ROPLogData$X05_immune)
#print(ROPLog)

matrix(c(ROPLogData[,1],ROPLogData[,2],ROPLogData[,3],ROPLogData[,4],ROPLogData[,5],ROPLogData[,6],ROPLogData[,7],ROPLogData[,8],ROPLogData[,9],ROPLogData[,10],ROPLogData[,11]),ncol=11,byrow=TRUE)
colnames(ROPLog) <- c(colnames(ROPLogData))
#colnames(ROPLogData)[1]
ROPLog <- as.table(ROPLog)
print(ROPLog)
#ROPLog is the table
print(attributes(ROPLog))
}
###ALL OF THE ABOVE MAY NOT EVEN BE NECESSARY --> CAN SIMPLY WORK WITH DATA FRAMES

library(ggplot2)
library(xtable)

PIVUS009Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS009_ROP/PIVUS009_Aligned--counts.csv',sep=',',header = TRUE)
PIVUS010Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS010_ROP/PIVUS010_Aligned--counts.csv',sep=',',header = TRUE)
PIVUS011Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS011_ROP/PIVUS011_Aligned--counts.csv',sep=',',header = TRUE)
PIVUS012Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS012_ROP/PIVUS012_Aligned--counts.csv',sep=',',header = TRUE)
PIVUS013Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS013_ROP/PIVUS013_Aligned--counts.csv',sep=',',header = TRUE)
PIVUS014Data <- read.csv(file='/users/j29tien/ROP/results/PIVUS014_ROP/PIVUS014_Aligned--counts.csv',sep=',',header = TRUE)


genome_profile <- rbind(PIVUS009Data, PIVUS010Data, PIVUS011Data, PIVUS012Data, PIVUS013Data, PIVUS014Data)
rownames(genome_profile) <- c("PIVUS009","PIVUS010","PIVUS011","PIVUS012","PIVUS013","PIVUS014")
print(genome_profile)

#sum(genome_profile["PIVUS003",])

#genome_profile_percentUnmapped <- genome_profile/total_unmapped_reads
#print(genome_profile_percentUnmapped)

#for (row in 1:nrow(genome_profile)) {
#genome_profile_percentMapped[row,] <-genome_profile[row,]/sum(genome_profile[row,])
#}
#print(genome_profile_percentMapped)

GenProfTable<-xtable(genome_profile, caption = "Genomic profile of PIVUS data (read counts)")
print.xtable(GenProfTable, type="html", file="GenProfTable.html")

digits=c(8,6,6,6,6,6,6,6,6,6,6,6)
print(length(digits))
#GenProfPercentageTable<-xtable(genome_profile_percentMapped, caption = "Genomic profile of PIVUS data (percentage of mapped reads after running ROP", digits=c(8,6,6,6,6,6,6,6,6,6,6,6))
#print.xtable(GenProfPercentageTable, type="html", file="GenProfPercentageTable.html")

