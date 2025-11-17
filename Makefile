# ---------------------------------------------------------
# type "make" command in Unix to create presentation.pdf file 
# ---------------------------------------------------------

# Main filename
MAIN=presentation

# ---------------------------------------------------------

default:
	pdflatex  ${MAIN}

all:
	pdflatex  ${MAIN}
	bibtex ${MAIN}
	pdflatex  ${MAIN}
	pdflatex  ${MAIN}

clean:
	(rm -rf *.aux *.bbl *.blg  *.log *.nav  *.out *.snm *.toc)

veryclean: clean
	(rm -rf *.pdf)

