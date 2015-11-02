library("ggplot2")
measures <- read.csv('measures.csv')

ggplot(measures,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point() +  ggtitle("Evolutionary algorithm language benchmarks")+scale_x_log10()+scale_y_log10()
