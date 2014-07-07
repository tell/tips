# -*- coding: utf-8-unix -*-

# Copyright (c) 2011-2011 Tadanori TERUYA (tell) <tadanori.teruya@gmail.com>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# @license: The MIT license <http://opensource.org/licenses/MIT>

## Tool settings

LATEX = platex
LATEXFLAGS = -halt-on-error -file-line-error -interaction=nonstopmode

BIBTEX = pbibtex
BIBTEXFLAGS =

MAKEINDEX = mendex

DVIPDFM = dvipdfmx
DVIPDFMFLAGS = -vv

BB = ebb

SED = sed
CP = cp -f
RM = rm -f

## Target settings

.PHONY : all clean

all:

clean:
	$(RM) *~ *.dvi *.bbl *.out *.ind *.idx

%.bb: %.pdf
	$(BB) $<

%.dvi: %.tex
	$(LATEX) $(LATEXFLAGS) $(@:%.dvi=%)
	$(BIBTEX) $(BIBTEXFLAGS) $(@:%.dvi=%)
	-$(MAKEINDEX) $(@:%.dvi=%)
	$(LATEX) $(LATEXFLAGS) $(@:%.dvi=%)
	$(LATEX) $(LATEXFLAGS) $(@:%.dvi=%)

## Characters ``--'' in LaTeX source codes, these are translated
## to ``\205'' in output file target.out. This causes mojibake.
## We replace these characters with ``-'' and then recompile, before
## running dvipdfm(x).
## Environment used to verify:
##   * Mac OS X 10.6
##   * ptexlive-20110322 (on TeXLive 2009)
%.pdf: %.dvi
	$(RM) $(@:%.pdf=%.out.temp)
	$(CP) $(@:%.pdf=%.out) $(@:%.pdf=%.out.temp)
	$(SED) -e "s/\\\205/-/g" $(@:%.pdf=%.out.temp) > $(@:%.pdf=%.out)
	$(LATEX) $(LATEXFLAGS) $(@:%.pdf=%)
	$(DVIPDFM) $(DVIPDFMFLAGS) $(@:%.pdf=%)
