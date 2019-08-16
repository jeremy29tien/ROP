library(ggplot2)
library(ggrepel)
library(dplyr)

is_outlier <- function(x,coef=1.5) {
  return(x < quantile(x, 0.25,na.rm = T) - coef * IQR(x,na.rm = T) | x > quantile(x, 0.75,na.rm = T) + coef * IQR(x,na.rm = T))
}
###
#data=data.frame(Sample=paste0("PIVUS",1:130),Age=factor(rep(c("Age 70","Age 80"),65)), Y=rnorm(n = 130,mean = ,sd = 1))
#data$Y[5]=-4
###

##Total Viral Reads
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/total-viral-count.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Proportion <- log(data$Proportion)

pvalue=wilcox.test(x = data$Proportion[data$Age=="Age 70"], y = data$Proportion[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Proportion), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Proportion, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/Total-Viral-Reads_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)


## Human alphaherpesvirus 1
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/human_alphaherpesvirus_1/human_alphaherpesvirus_1.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/human_alphaherpesvirus_1/human_alphaherpesvirus_1_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)

##Encephalomyocarditis virus
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/encephalomyocarditis_virus/encephalomyocarditis_virus.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/encephalomyocarditis_virus/encephalomyocarditis_virus_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)

##Hepacivirus C
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/hepacivirus_c/hepacivirus_c.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/hepacivirus_c/hepacivirus_c_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)

##Human alphaherpesvirus 2
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/human_alphaherpesvirus_2/human_alphaherpesvirus_2.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/human_alphaherpesvirus_2/human_alphaherpesvirus_2_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)

##Mengo virus
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/mengo_virus/mengo_virus.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/mengo_virus/mengo_virus_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)

##Foot-and-mouth disease virus - type Asia 1
data=read.csv("/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/foot-and-mouth_disease_virus_-_type_asia_1/foot-and-mouth_disease_virus_-_type_asia_1.csv")
data<-data[!(data$Sample =="PIVUS039"),] # doesn't have PIVUS040 (80 yr old) pair
data <- cbind(data, Age=factor(rep(c("Age 70","Age 80"),64)))
data$Scaled.for.total.ROP.mapped.read.count <- log(data$Scaled.for.total.ROP.mapped.read.count)

pvalue=wilcox.test(x = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 70"], y = data$Scaled.for.total.ROP.mapped.read.count[data$Age=="Age 80"], paired = T)$p.value

p=ggplot(data = data %>% group_by(Age)  %>% mutate(outlier=ifelse(is_outlier(Scaled.for.total.ROP.mapped.read.count), yes = as.character(Sample),no = "")), mapping = aes(x = Age, y = Scaled.for.total.ROP.mapped.read.count, fill=Age)) + geom_boxplot() + geom_text_repel(mapping = aes(label=outlier), size=5) + scale_fill_manual(values = c("darkred", "darkblue")) + ylab("Viral Reads\n (log, scaled by total reads)") + theme_bw() + theme(axis.title.x = element_blank(), axis.text.x = element_text(color="black", size = 17), axis.title.y = element_text(size=20),  axis.text.y = element_text(size=12), legend.position = "none") + annotate(geom = "text", x = 1.5, y = 4, label=paste0("p-value=",format(x = pvalue, digits = 2, scientific = T)), size=5)
print(p)

ggsave(filename = "/Users/JeremyTien/Documents/SIMR 2018/PIVUS_ROP_ImReP/VIRAL/foot-and-mouth_disease_virus_-_type_asia_1/foot-and-mouth_disease_virus_-_type_asia_1_scaled_log_pvalue.pdf", plot = p, width = 7, height = 10)
