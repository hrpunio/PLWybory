#!/usr/bin/perl
#

open (T, "komisje-frekwencja-ws2014-coords.csv");
while (<T>) { chomp();
  ($teryt, $nrk, $nro, $adres, $lwug, $lkw, $lkwzu, $lgnw, $lgw, 
    $freq, $pgnw, $idk, $coords) = split /;/, $_;
  $CNn{$coords}++;
  $CId{$coords} .= "$teryt-$nro;";
}

for $id (keys %CNn ) {    print "$CNn{$id} $id\n" };
