#Use this file to store code (including formatting and nice colors) of FINAL graphs and plots

human_alphaherpesvirus_1 <- read.csv("/users/j29tien/ROP/results/VIRAL/human_alphaherpesvirus_1/70-80_human_alphaherpesvirus_1.csv")
scaled_human_alphaherpesvirus_1 <- read.csv("/users/j29tien/ROP/results/VIRAL/human_alphaherpesvirus_1/scaled_70-80_human_alphaherpesvirus_1.csv")
boxplot( human_alphaherpesvirus_1$Age.70,  human_alphaherpesvirus_1$Age.80, col = c("red1","red4"), names=c("Age 70", "Age 80"))
dev.copy(pdf, "human_alphaherpesvirus_1_counts.pdf")
dev.off()
boxplot(scaled_human_alphaherpesvirus_1$Age.70, scaled_human_alphaherpesvirus_1$Age.80, col = c("red1","red4"), names=c("Age 70", "Age 80"))
dev.copy(pdf, "human_alphaherpesvirus_1_scaled.pdf")
dev.off()

encephalomyocarditis_virus <- read.csv("/users/j29tien/ROP/results/VIRAL/encephalomyocarditis_virus/70-80_encephalomyocarditis_virus.csv")
scaled_encephalomyocarditis_virus <- read.csv("/users/j29tien/ROP/results/VIRAL/encephalomyocarditis_virus/scaled_70-80_encephalomyocarditis_virus.csv")
boxplot(encephalomyocarditis_virus$Age.70, encephalomyocarditis_virus$Age.80, col = c("lightsalmon","sienna1"), names=c("Age 70", "Age 80"))
dev.copy(pdf,'encephalomyocarditis_virus_counts.pdf')
dev.off()
boxplot(scaled_encephalomyocarditis_virus$Age.70, scaled_encephalomyocarditis_virus$Age.80, col = c("lightsalmon","sienna1"), names=c("Age 70", "Age 80"))
dev.copy(pdf,'encephalomyocarditis_virus_scaled.pdf')
dev.off()







encephalomyocarditis_virus <- read.csv("/users/j29tien/ROP/results/VIRAL/encephalomyocarditis_virus/70-80_encephalomyocarditis_virus.csv")
scaled_encephalomyocarditis_virus <- read.csv("/users/j29tien/ROP/results/VIRAL/encephalomyocarditis_virus/scaled_70-80_encephalomyocarditis_virus.csv")
boxplot(encephalomyocarditis_virus$Age.70, encephalomyocarditis_virus$Age.80, col = c("lightskyblue","royalblue2"), names=c("Age 70", "Age 80"))
dev.copy(pdf,'encephalomyocarditis_virus_counts.pdf')
dev.off()
boxplot(scaled_encephalomyocarditis_virus$Age.70, scaled_encephalomyocarditis_virus$Age.80, col = c("lightskyblue","royalblue2"), names=c("Age 70", "Age 80"))
dev.copy(pdf,'encephalomyocarditis_virus_scaled.pdf')
dev.off()
