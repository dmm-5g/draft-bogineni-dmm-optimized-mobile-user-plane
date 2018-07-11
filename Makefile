SHELL:=/bin/bash
LIBDIR := lib
include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell git submodule status $(LIBDIR) 2>/dev/null))
		git submodule sync
		git submodule update $(CLONE_ARGS) --init
else
		git clone -q --depth 10 $(CLONE_ARGS) \
			-b master https://github.com/martinthomson/i-d-template $(LIBDIR)
endif

setup:
		@mkdir -p contrib
		@test -s $(LIBDIR) || git clone https://github.com/martinthomson/i-d-template $(LIBDIR)
		@apt install ruby-kramdown-rfc2629 enscript

cleanall:
		@rm *.txt *.html *.pdf
