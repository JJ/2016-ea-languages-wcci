#!/usr/bin/env perl

use strict;
use warnings;

use v5.14;

use File::Slurp::Tiny qw(read_lines);

my @measure_files = glob "measures*.csv";

my (%ratios, %measures);
say "Language, Ratio";
for my $f ( @measure_files ) {
  my @contents= read_lines( $f );

  for my $l ( @contents[1..$#contents] ) {
    chomp $l;
    next if !$l;
    my ($langrep, $len, $value ) = split(/\s*,\s*/,$l);
    if ( !$len ) {
      say "Error in $l";
    }
    $measures{$len}{$langrep} = $value;
  }

  for my $len ( keys %measures ) {
    next if $len > 60000; # No Julia
    for my $lg ( keys %{$measures{$len}} ) {
      my $ratio = $measures{$len}{'julia-BitString'}/$measures{$len}{$lg};
#      say "$len, $lg, ", $measures{$len}{'julia-BitString'}/$measures{$len}{$lg} /;
      say "$lg, $ratio";
    }
  }
}


