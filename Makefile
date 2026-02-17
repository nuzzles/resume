RESUME_SRC = resume.tex
COVERLETTER_SRC = coverletter.tex
OUTPUT_DIR = ./aux
INDEX_TEMPLATES = templates/index.html.j2
EMBED_TEMPLATES = templates/embed.html.j2

.PHONY: all clean open

all: clean resume coverletter

clean:
	rm -rf $(OUTPUT_DIR)
	rm -f *.pdf
	rm -f *.html

resume:
	$(call create-output-dir)
	latexmk -xelatex -shell-escape -output-directory $(OUTPUT_DIR) $(RESUME_SRC) || \
		xelatex --shell-escape -output-directory $(OUTPUT_DIR) $(RESUME_SRC)
	mv $(OUTPUT_DIR)/$(RESUME_SRC:.tex=.pdf) .
	PDF='$(RESUME_SRC:.tex=.pdf)' j2 $(INDEX_TEMPLATES) > resume.html
	PDF='$(RESUME_SRC:.tex=.pdf)' j2 $(EMBED_TEMPLATES) > embed-resume.html

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