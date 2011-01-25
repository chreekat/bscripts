#!/usr/bin/perl -w

use strict;

my @in_list;
my $num_remaining;
my @rand_list;

{
local $/ = undef;
@in_list = split "\n", <STDIN>;
}

while ( ($num_remaining = @in_list) > 0) {
    my $nxt = int(rand($num_remaining));
    push @rand_list, 
        splice(@in_list, $nxt, 1);
}

print join "\n", @rand_list;
