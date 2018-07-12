## ----setup, cache=FALSE,echo=FALSE---------------------------------------
library("ggplot2")
library("RColorBrewer")
measures.mo <- read.csv('measures-maxones-2018.csv',header=TRUE,sep=",",dec=".")
measures.bf <- read.csv('measures-bitflip-2018.csv',header=TRUE,sep=",",dec=".")
measures.xo <- read.csv('measures-xover-2018.csv',header=TRUE,sep=",",dec=".")
measures.perl6 <- read.csv('measures-maxones-perl6.csv',header=TRUE,sep=",",dec=".")
measures.rr <- read.csv('measures-royalroad.csv',header=TRUE,sep=",",dec=".")

## ----results-perl6, cache=FALSE,echo=FALSE-------------------------------
getPalette = colorRampPalette(brewer.pal(9, "Set1"))
colourCount = length(unique(measures.perl6$Version))
ggplot(measures.perl6,aes(x=length,y=time,colour=factor(Version)))+ geom_line() + geom_point()  + ggtitle("Perl6 language benchmarks: Onemax") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))

## ----results-mo, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.mo$languagerepresentation))
ggplot(measures.mo,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point()  + ggtitle("Evolutionary algorithm language benchmarks: Onemax") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))
ggsave("img/results-mo.png", width=8,height=4.5)

## ----results-bf, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.bf$languagerepresentation))
ggplot(measures.bf,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point()  + ggtitle("Evolutionary algorithm language benchmarks: Bitflip mutation") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))
ggsave("img/results-bf.png", width=8,height=4.5)

## ----results-xo, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.bf$languagerepresentation))
ggplot(measures.xo,aes(x=length,y=time,colour=factor(languagerepresentation)))+ geom_line() + geom_point()  + ggtitle("Evolutionary algorithm language benchmarks: Crossover") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))

## ----results-rr, cache=FALSE,echo=FALSE----------------------------------
colourCount = length(unique(measures.rr$Version))
ggplot(measures.rr,aes(x=length,y=time,colour=factor(Version)))+ geom_line() + geom_point()  + ggtitle("Comparing Perl 5 and Perl 6 using the Royal Road Function") + scale_y_log10()+scale_x_log10() + scale_color_manual(name='Language',values=getPalette(colourCount)) + theme( legend.text=element_text(size=10))
ggsave("img/results-rr.png", width=8,height=4.5)
