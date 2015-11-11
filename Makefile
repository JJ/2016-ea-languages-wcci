SUB = $(find . -maxdepth 1 -mindepth 1 -type d)
RNW = $(wildcard *.Rnw)
TEX = $(RNW:.Rnw=.tex)
PDF = $(TEX:.tex=.pdf)

all: $(PDF)

auto:
	latexmk -bibtex -f -pdf -pvc

clean:
	-rm $(PDF) $(TEX)
	latexmk -C
	for i in $(SUB); do $(MAKE) -C $$i clean; done

install:
	sudo dnf -y install R texlive-framed
	R -e 'install.packages("knitr", dependencies = TRUE)'
	R -e 'install.packages("ggplot2")'

%.tex: %.Rnw
	R -e 'library(knitr);knit("$<")'

%.pdf: %.tex
	latexmk -bibtex -pdf $*

.PHONY: all auto clean install
