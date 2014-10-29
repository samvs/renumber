renumber
========

Perl scripts for renumbering footnotes in markdown documents

This repository contains a Perl script to renumber footnotes in Markdown file sequentially, while also renumbering the footnote references.

It only works where footnotes are in the format [^xxxx] and references are [^xxxx]: (where xxxx can be any alphanumeric sequence up to 10 characters.

It includes an option to check that the footnotes and the footnote references are in the same order (otherwise it is likely that they will not match once renumbered): type "-c" after the program name when running it in the shell.

The output file with renumbered footnotes and footnote references is given the filename "renumbered.md"