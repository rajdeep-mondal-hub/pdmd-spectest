#!/usr/bin/perl
#
# John Gabriele, 2012

use Modern::Perl;
use autodie qw/:all/;

my $md_processor = $ARGV[0];
print "Checking output of: ", `which $md_processor`;

chdir 'input-md';

for my $fn (glob '*.md') {
    my $pandoc_output = `pandoc $fn`;
    my $other_output  = `$md_processor $fn`;
    my $fn2 = $fn;
    $fn2 =~ s/\.md$//;
    print $fn2, " ...\t";
    $pandoc_output =~ s/\s+/ /g;
    $other_output  =~ s/\s+/ /g;
    if ($pandoc_output eq $other_output) {
        say "OK";
    }
    else {
        say "-- not the same --";
    }
}
