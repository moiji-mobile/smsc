VER=$(shell xmllint --xpath "//revision[last()]/revnumber/text()" manual-docinfo.xml)

all: osmo-smsc-manual-v$(VER).pdf _sphinx/index.rst

osmo-smsc-manual-v$(VER).pdf: manual-docinfo.xml styles/custom-dblatex.sty *.adoc *.asciidoc images/*.png
	a2x -L --dblatex-opts=" -s styles/custom-dblatex.sty" -a docinfo manual.adoc
	mv manual.pdf $@

_sphinx/index.rst: osmo-smsc-manual-v$(VER).pdf
	a2x -L -a docinfo -f docbook manual.adoc
	pandoc -s -f docbook -t rst -o _sphinx/index.rst manual.xml
	$(RM) manual.xml

clean:
	$(RM) *.pdf
