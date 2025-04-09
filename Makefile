# Makefile for compiling LaTeX tutorials document

# Variables
DOCUMENT = Tutorials
TEX_FILE = $(DOCUMENT).tex
PDF_FILE = $(DOCUMENT).pdf

# Default target
all: $(PDF_FILE)

# Rule to build PDF from TEX
$(PDF_FILE): $(TEX_FILE)
	pdflatex $(TEX_FILE)
	pdflatex $(TEX_FILE)  # Run twice for references
	pdflatex $(TEX_FILE)  # jednak standard to trzy razy
# Clean up temporary files
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot *.bbl *.blg *.fls *.fdb_latexmk *.synctex.gz

# Remove PDF as well
cleanall: clean
	rm -f $(PDF_FILE)

# Phony targets
.PHONY: all clean cleanall
