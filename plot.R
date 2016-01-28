library("ggplot2")

ratios <- read.csv('ratios.dat')
ggplot(ratios,aes(x=Language,y=Ratio))+ geom_boxplot(notch=TRUE)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+scale_y_log10()
