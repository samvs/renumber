renumber
========

Perl scripts for renumbering footnotes in markdown documents.

This repository contains a Perl script called *renumber-footnotes.pl* to renumber footnotes in Markdown file sequentially, while also renumbering the footnote references.

It only works where footnotes are in the format [^xxxx] and references are [^xxxx]: (where xxxx can be any alphanumeric sequence up to 10 characters.

It includes an option to check that the footnotes and the footnote references are in the same order (otherwise it is likely that they will not match once renumbered): type "-c" after the program name when running it in the shell.

The output file with renumbered footnotes and footnote references is given the filename "renumbered.md"

A short version of the script intended to be used within BBEdit as a text filter is also included: *renumber_BBEdit.pl*.

I have also included here a brief script to renumber sequentially the *n* attribute of *MsDescription* elements in a TEI file. I use this with the TEI p4 catalogue files in the IDPcatalogue repository. For p5, the element should be *MsDesc*.
