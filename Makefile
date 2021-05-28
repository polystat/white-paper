.SHELLFLAGS = -e -c

.ONESHELL:

TEXS := $(wildcard *.tex)
PDFS := $(patsubst %.tex,%.pdf,$(TEXS))

all: $(PDFS)

clean:
	rm -rf *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out
	rm -rf _minted*
	rm -rf $(PDFS)

%.pdf: %.tex
	latexmk -pdf $<
	texqc $<
	texsc --pws aspell.en.pws \
		--ignore definecolor:ppp \
		--ignore AddEverypageHook \
		--ignore tikzpicture,minted,addbibresource \
		--ignore citet,citep,nospell,code,setlist,setminted,captionsetup \
		$<
