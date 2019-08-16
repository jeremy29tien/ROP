library(ggplot2)
viraldata <- read.csv("/users/j29tien/ROP/results/70-80_human_alphaherpesvirus_1.csv")
sp<-ggplot(viraldata, aes(x = alphaherpes$Age.70, y = alphaherpes$Age.80)) + geom_point()
