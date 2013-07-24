SHELL := /bin/bash
PATH:=/c/unix/tex/bin/:$(PATH)

TARGET=T-frog_Motor_Driver_Manual
OBJDIR=./obj
PDFDIR=./

TEX=$(TARGET).tex
DVI=$(TARGET).dvi
PDF=$(TARGET).pdf

SDVI=c:/unix/tex/dviout/dviout.exe

LATEX=platex -output-directory=$(OBJDIR) --kanji=utf8
DVI2PDF=dvipdfmx
EMBFONT=-f koz.map

all: $(DVI)

sdvi:$(DVI)
	$(SDVI) $< &

pdf:$(PDF)

pdfkoz:
	$(DVI2PDF) $(EMBFONT) $(DVI)

clean: 
	rm -f $(OBJDIR)/$(TARGET).aux
	rm -f $(DVI)
	rm -f $(OBJDIR)/$(TARGET).log
	rm -f *~

$(DVI): $(TEX) fig/*.eps
	$(LATEX) $<
	if grep -q "Label(s) may have changed." $(OBJDIR)/$(TARGET).log; then $(LATEX) $<; fi
	if grep -q "Label(s) may have changed." $(OBJDIR)/$(TARGET).log; then $(LATEX) $<; fi
	cp $(OBJDIR)/$(DVI) ./$(DVI)

$(PDF): $(DVI)
	$(DVI2PDF) $<

