#!/usr/bin/perl
use strict;

# Program to add or overwrite sequential numbers to the n attribute of the msDescription element in TEI XML documents.

print "Enter the name of the xml file for adding or fixing msDescription numbers. Renumbered file will be saved as renumbered.xml.\n";

chomp (my $filename = <STDIN>);
open my $input_file,'<', $filename or die $!;
open my $output_file,'>', 'renumbered.xml' or die $!;

my $catnumber=1;

# This loop matches the msDescription element and replaces the content of the n attribute with sequential numbers (or adds sequential numbers if there is nothing to replace).

while (<$input_file>) {
  if (/msDescription n=".{0,50}"/) {
    s/msDescription n=".{0,50}"/msDescription n="$catnumber"/;
    print $output_file $_;
    $catnumber++;
  }
    else {
    print $output_file $_; # print everything else to the output file
  }
}

close $input_file;
close $output_file;

$catnumber--; # Because we added 1 to $catnumber after the last substitution.

print "Done, $catnumber msDescription elements renumbered.\n";
