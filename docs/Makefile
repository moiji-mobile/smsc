VER=$(shell xmllint --xpath "//revision[last()]/revnumber/text()" manual-docinfo.xml)

osmo-smsc-manual-v$(VER).pdf: manual-docinfo.xml styles/custom-dblatex.sty *.adoc *.asciidoc images/*.png
	a2x -L --dblatex-opts=" -s styles/custom-dblatex.sty" -a docinfo manual.adoc
	mv manual.pdf $@

clean:
	$(RM) *.pdf
