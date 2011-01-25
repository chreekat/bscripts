#!/usr/bin/perl

sub alarm;

$inp = shift @ARGV;
($s, $m, $h) = reverse split /:/, $inp;

die "What?\n" unless $s;

($s, $unit, $rep_p, $junk) = $s =~ /(\d+)([msh]?)(r?)(.*)/;

die "I don't understand\n" 
    if (  $junk
       || ($unit && 'hsm' !~ /$unit/)
       || ($unit eq 's' && $m) 
       || ($unit eq 'm' && $h)
    );

while ($unit eq "h" && ! $h) {
    $h = $m;
    $m = $s;
    $s = 0;
}

if ($unit eq "m" && ! $m) {
    $m = $s;
    $s = 0;
}

$time = $h * (60*60) + $m * 60 + $s;

do {
    sleep $time;
    unless (fork) {
        &alarm;
        exit;
    }
} while ($rep_p);

# this sub takes about 6 seconds, so timing < 6 seconds is out (unless
# you change this sub)
sub alarm {
    for (1..3) {
        system "banner 'TIME'"; 
        sleep 1;
    }
}
