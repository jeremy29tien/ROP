#This R script will take input in the form of viral name and generate appropriate boxplots for it. It is meant for temporary visualization only, without pretty colors or otherwise well-formatted/presentable plots. 

args = commandArgs(trailingOnly=TRUE)
# test if there is at least one argument: if not, return an error                              
if (length(args)==0) {
  stop("Please provide the directory name of the virus you wish to be boxplotted.", call.=FALSE)                                                     
}
virus=args[1]

viraldata <- read.csv(paste("/users/j29tien/ROP/results/VIRAL/",virus,"/70-80_",virus,".csv",sep=""))
scaled_viraldata <- read.csv(paste("/users/j29tien/ROP/results/VIRAL/",virus,"/scaled_70-80_",virus,".csv",sep=""))
boxplot(viraldata$Age.70, viraldata$Age.80, col = c("lightskyblue","royalblue2"), names=c("Age 70", "Age 80"))
dev.copy(pdf,paste(virus,"_counts.pdf",sep=""))
dev.off()
boxplot(scaled_viraldata$Age.70, scaled_viraldata$Age.80, col = c("lightskyblue","royalblue2"), names=c("Age 70", "Age 80"))
dev.copy(pdf,paste(virus,"_scaled.pdf",sep=""))
dev.off()
