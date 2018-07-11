SHELL:=/bin/bash

COM = pandoc
BEAMER = -s -t beamer  -V aspectratio:169  -V fontsize=8pt --filter $(PWD)/columnfilter.py
DEPS = draft-bogineni-dmm-slides.md

slide: $(DEPS)
	$(COM) $(BEAMER) $(DEPS) -o draft-bogineni-dmm-slides.pdf

cleanall:
		@rm *.html *.pdf