RESUME_SRC = resume.tex
COVERLETTER_SRC = coverletter.tex
OUTPUT_DIR = ./aux
INDEX_TEMPLATES = templates/index.html.j2
EMBED_TEMPLATES = templates/embed.html.j2

COMPANY = $(word 2,$(MAKECMDGOALS))

.PHONY: all clean open resume coverletter
# Absorb the optional company-stem argument passed to `make resume <stem>`
$(COMPANY):

all: clean resume coverletter

clean:
	rm -rf $(OUTPUT_DIR)
	rm -f *.pdf
	rm -f *.html

resume:
	$(call create-output-dir)
	$(if $(COMPANY),\
		sed 's|companies/blueorigin|companies/$(COMPANY)|' \
			sections/heading_applying.tex > sections/_resume_heading.tex && \
		sed 's|heading_employed|_resume_heading|' \
			$(RESUME_SRC) > _resume.tex,\
		cp $(RESUME_SRC) _resume.tex)
	latexmk -xelatex -shell-escape -output-directory $(OUTPUT_DIR) _resume.tex || \
		xelatex --shell-escape -output-directory $(OUTPUT_DIR) _resume.tex
	mv $(OUTPUT_DIR)/_resume.pdf resume.pdf
	rm -f _resume.tex sections/_resume_heading.tex
	PDF='resume.pdf' j2 $(INDEX_TEMPLATES) > resume.html
	PDF='resume.pdf' j2 $(EMBED_TEMPLATES) > embed-resume.html

coverletter:
	$(call create-output-dir)
	latexmk -xelatex -shell-escape -output-directory $(OUTPUT_DIR) $(COVERLETTER_SRC) || \
		xelatex --shell-escape -output-directory $(OUTPUT_DIR) $(COVERLETTER_SRC)
	mv $(OUTPUT_DIR)/$(COVERLETTER_SRC:.tex=.pdf) .
	PDF='$(COVERLETTER_SRC:.tex=.pdf)' j2 $(INDEX_TEMPLATES) > coverletter.html
	PDF='$(COVERLETTER_SRC:.tex=.pdf)' j2 $(EMBED_TEMPLATES) > embed-coverletter.html

open:
	@if [ -f "resume.pdf" ]; then\
		xdg-open resume.pdf || open resume.pdf || explorer.exe resume.pdf;\
	fi
	@if [ -f "coverletter.pdf" ]; then\
		xdg-open coverletter.pdf || open coverletter.pdf || explorer.exe coverletter.pdf;\
	fi

define create-output-dir
	rm -rf $(OUTPUT_DIR)
	mkdir -p $(OUTPUT_DIR)
endef
