# The MIT License (MIT)
#
# Copyright (c) 2021 Polystat.org
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

.SHELLFLAGS = -e -c

.ONESHELL:

TEXS := $(wildcard *.tex)
PDFS := $(patsubst %.tex,%.pdf,$(TEXS))

all: $(PDFS)

clean:
	rm -rf *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.log *.run.xml *.out
	rm -rf _minted*
	rm -rf $(PDFS)

%.pdf: %.tex *.bib
	texliveonfly -a '--shell-escape' $<
	latexmk -pdf $<
	texqc $<
	texsc --pws aspell.en.pws \
		--ignore definecolor:ppp \
		--ignore AddEverypageHook \
		--ignore tikzpicture,minted,addbibresource \
		--ignore citet,citep,nospell,code,setlist,setminted,captionsetup \
		$<
