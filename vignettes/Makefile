LATEXFILES = *.aux\
	*.bbl\
	*.blg\
	*.ilg\
	*.log\
	*.nlo\
	*.nls\
	*.toc\
	*.aux\
	Rplots.pdf\
	*.dvi\
	*.map\
	*.out\
	*.figlist\
	*.dep\
	*.dpth\
	*.makefile\
	qcmetrics.tex

all: 
	make vig

setvars:
ifeq (${R_HOME},)
R_HOME= $(shell R RHOME)
endif

vig:
	"$(R_HOME)/bin/R" CMD pdflatex qcmetrics.tex
##	bibtex qcmetrics
##	"$(R_HOME)/bin/R" CMD pdflatex qcmetrics.tex
	"$(R_HOME)/bin/R" CMD pdflatex qcmetrics.tex


## manual building
vig2: 
	"$(R_HOME)/bin/R" --vanilla -e "library(knitr); knit2pdf('qcmetrics.Rnw');"
##	bibtex qcmetrics
##	"$(R_HOME)/bin/R" CMD pdflatex qcmetrics.tex
	"$(R_HOME)/bin/R" CMD pdflatex qcmetrics.tex



.PHONY: clean allclean 

clean:	
	rm -f $(LATEXFILES)
	rm -f .Rhistory
	rm -f *~
	rm -f */*~


allclean: clean
	rm -f  qcmetrics.pdf
	rm -rf figure/
	rm -rf cache/
