#!/usr/bin/perl
use strict;

# Program to renumber footnotes in Markdown file sequentially, also renumbering the footnote references.
# Only works where footnotes are [^xxxx] and references are [^xxxx]: (where xxx can be any alphanumeric sequence up to 10 characters.
# Changes the $/ variable to "[" to match each beginning of a footnote.
# Includes an option to check that the footnotes match the footnote references: type "-c" after the program name when running it in the shell.
# v.5 replaced the code's fileglobs to variables.
# v.6 Updated to change both footnotes and footnote references at the same time.
# v.7 Changed the flag to "-c" and changed the max number of characters in a footnote ref. to 10.

print "Enter the name of the multimarkdown file for fixing footnote numbers. Renumbered file will be saved as renumbered.md.\n";

chomp (my $filename = <STDIN>);
open my $input_file,'<', $filename or die $!;
open my $output_file,'>', 'renumbered.md' or die $!;

$/ = "["; # Change the iterator for the while loops below to match the beginning of each footnote.

# If the user has typed "-c" after the program name, we check that the footnotes and footnote references are in the same order, and give an alert if they are not (because if the two do not match, renumbering will not help).

if ($ARGV[0] eq "-c") {

  my @fn;
  my @fn_ref;

  # This loop populates the @fn and @fn_ref arrays with the values of the footnotes and footnote references.
  while (<$input_file>) {
    if (/\^(.{1,10})\][^:]/g) {
      push @fn, $1;
    }
    if (/\^(.{1,10})\]:/g) {
      push @fn_ref, $1;
    }
  }

# This loop compares the two arrays and quits with an alert if they do not match.
  my $item = 0;
  foreach (@fn) {
    if ($fn_ref[$item] eq '') {
      print "More footnotes than references!\n" and die;
    }
    if ($_ ne $fn_ref[$item]) {
      print "Footnotes and footnote refs don't match!\n" and die;
    }
    $item++;
  }
}

# The main part of the program, renumbering footnotes and footnote references sequentially.

seek $input_file, 0, 0; 		# Return to beginning of the file.

my $footnote=1;
my $footnote_ref=1;

# This loop matches footnotes in [^xxx] format, substitutes the footnote number with $footnote, then  matches footnote references in [^xxx]: format, substitutes the number with $footnote_ref, and prints the matched & substituted text to output file.

while (<$input_file>) {
  if (/\^.{1,10}\][^:]/g) {
    s/\^.{1,10}\]/\^$footnote\]/;
    print $output_file $_;
	$footnote++;
  }
    elsif (/\^.{1,10}\]:/g) {
    s/\^.{1,10}\]:/\^$footnote_ref\]:/;
    print $output_file $_;
    $footnote_ref++;
  }
    else {
    print $output_file $_; # print everything else to the output file
  }
}

close $input_file;
close $output_file;

$footnote--; # Because we added 1 to $footnote after the last substitution.

print "Done, $footnote footnotes renumbered.\n";
