#!/usr/bin/perl
#
# John Gabriele, 2012

use Modern::Perl;
use autodie qw/:all/;

if (@ARGV < 1 or @ARGV > 2) {
    say "Usage:\n";
    say "    ./pdmd-spectest <mkdn-impl>";
    say "    ./pdmd-spectest <mkdn-impl> <particular-test>\n";
    say "Where <particular-test> is one of the filenames in";
    say "input-md, sans the .md filename extension.";
    exit;
}

my $md_processor = $ARGV[0];
print "For Markdown processor: ", `which $md_processor`;

my $specific_test = 0;
if (@ARGV == 2) {
    $specific_test = $ARGV[1];
    my $fn = "input-md/$specific_test.md";
    if (! -e $fn) {
        say "Unable to locate $fn file. Exiting.";
        exit;
    }
}

chdir 'input-md';

sub get_output_for {
    my ($md_proc, $fn) = @_;
    my $output = `$md_proc $fn`;
    $output =~ s/\s+/ /g;
    return $output;
}

if ($specific_test) {
    my $fn = "$specific_test.md";
    say "Checking output for ", $fn;
    my $pandoc_output = get_output_for('pandoc', $fn);
    my $other_output  = get_output_for($md_processor, $fn);
    if ($pandoc_output eq $other_output) {
        say "OK";
    }
    else {
        say "Not the same. Here are both outputs (pandoc first):";
        say $pandoc_output;
        say $other_output;
    }
}
else {
    for my $fn (glob '*.md') {
        my $pandoc_output = get_output_for('pandoc', $fn);
        my $other_output  = get_output_for($md_processor, $fn);
        my $fn2 = $fn;
        $fn2 =~ s/\.md$//;
        print $fn2, " ...\t";
        if ($pandoc_output eq $other_output) {
            say "OK";
        }
        else {
            say "-- not the same --";
        }
    }
}
