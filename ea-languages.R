## ----setup, cache=FALSE,echo=FALSE---------------------------------------
library("ggplot2")
library(RColorBrewer)
measures.bf <- read.csv('measures-bitflip-2018.csv')
measures.xo <- read.csv('measures-xover-2018.csv')
measures.mo <- read.csv('measures-maxones-2018.csv',header=TRUE,sep=",",dec=".")

## ----results-bf, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.bf$languagerepresentation))
getPalette = colorRampPalette(brewer.pal(9, "Set1"))
ggplot(measures.bf,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point() +  ggtitle("Evolutionary algorithm language benchmarks: Bitflip")+scale_y_log10()+scale_x_log10()+scale_color_manual(name='Language',values=getPalette(colourCount))

## ----results-xo, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.xo$languagerepresentation))
ggplot(measures.xo,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point() +  ggtitle("Evolutionary algorithm language benchmarks: Crossover")+scale_y_log10()+scale_x_log10()+scale_color_manual(name='Language',values=getPalette(colourCount))

## ----results-mo, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.mo$languagerepresentation))
ggplot(measures.mo,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point()  + ggtitle("Evolutionary algorithm language benchmarks: Onemax") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))

## ----results-ratios,message=FALSE, cache=FALSE,echo=FALSE----------------
ratios <- read.csv('ratios.dat')
ggplot(ratios,aes(x=reorder(Language, -Ratio, FUN=median),Language,y=Ratio))+ geom_boxplot(notch=TRUE)+ theme(axis.text.x = element_text(angle = 90, hjust = 1))+scale_y_log10()+labs(x='Language')

