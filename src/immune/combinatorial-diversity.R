

IGKDiversity <- read.csv("/users/j29tien/ROP/results/PIVUS003_ROP/06_immune/PIVUS003_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE)
if (!nrow(IGKDiversity)==0) {
sample_names <- c("PIVUS003")
}

temp <- read.csv("/users/j29tien/ROP/results/PIVUS004_ROP/06_immune/PIVUS004_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE)
if (!nrow(temp)==0) {
sample_names <- c(sample_names,"PIVUS004")
IGKDiversity <- rbind(temp,IGKDiversity)
}


temp <- read.csv("/users/j29tien/ROP/results/PIVUS005_ROP/06_immune/PIVUS005_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE)
if (!nrow(temp)==0) {
sample_names <- c(sample_names,"PIVUS005")
IGKDiversity <- rbind(temp, IGKDiversity)
}

#####NOT FINISHED, DECIDED TO ABORT. THIS WILL TAKE TOO MUCH CODE FOR ALL SAMPLES. WILL HAVE TO DECIDE WHETHER TO WRITE IT FOR ALL SAMPLES OR JUST FILL OUT EXCEL BY HAND.


IGKDiversity <- rbind(read.csv("/users/j29tien/ROP/results/PIVUS006_ROP/06_immune/PIVUS006_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE), IGKDiversity)
if (!nrow(temp==0) {
sample_names <- c(sample_names,"PIVUS007")
}

IGKDiversity <- rbind(read.csv("/users/j29tien/ROP/results/PIVUS007_ROP/06_immune/PIVUS007_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE), IGKDiversity)
if (!nrow(temp==0) {
sample_names <- c(sample_names,"PIVUS008")
}

IGKDiversity <- rbind(read.csv("/users/j29tien/ROP/results/PIVUS008_ROP/06_immune/PIVUS008_Aligned--06_immune_clonality/IGK.VJ.FREQ.06_immune.csv", sep=",", header=TRUE), IGKDiversity)
if (!nrow(temp==0) {
sample_names <- c(sample_names,"PIVUS004")
}


print(IGKDiversity)



