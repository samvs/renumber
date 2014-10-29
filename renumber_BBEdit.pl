#!/usr/bin/perl                                                                

# Script to renumber footnotes in Markdown file sequentially, separately renumbering the footnote references if they are preceded by a second-level header (##) followed by the word References, Notes, Footnotes, or Endnotes.   

my $footnote=1;

$/ = "[";

while (<>) {
  if (/\^.{1,4}\]/g) {
    s/\^.{1,4}\]/\^$footnote\]/;
    print;                                                                           
    $footnote++;
  }
  else {
    print;
  }
      $footnote = 1 if /(## References|## Notes|## Footnotes|## Endnotes)/;
}
