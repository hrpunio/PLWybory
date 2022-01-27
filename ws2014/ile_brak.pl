#!/usr/bin/perl
%Woj = (
 '02' => 'Dolnośląskie',
 '04' => 'Kujawsko-Pomorskie',
 '06' => 'Lubelskie',
 '08' => 'Lubuskie',
 '10' => 'Łódzkie',
 '12' => 'Małopolskie',
 '14' => 'Mazowieckie',
 '16' => 'Opolskie',
 '18' => 'Podkarpackie',
 '20' => 'Podlaskie',
 '22' => 'Pomorskie',
 '24' => 'Śląskie',
 '26' => 'Świętokrzyskie',
 '28' => 'Warmińsko-Mazurskie',
 '30' => 'Wielkopolskie',
 '32' => 'Zachodniopomorskie',);

## ##  ##
open (O, "ws2014_votes_freq_coords_icons.csv");
## teryt;nrk;nro;adres;
while(<O>) { chomp();
  @tmp= split /;/, $_;
  $T{"$tmp[0]$tmp[2]"} = $tmp[3];
}
print "*** $r found\n";
close (O);

open (O, "idkomisji_teryt_nrobwodu.csv");
## id;teryt;nro
while(<O>) { chomp();
  @tmp= split /;/, $_;
  unless (exists ($T{"$tmp[1]$tmp[2]"}) ) {
     $tmp[1] =~ /^([0-9][0-9])/; $woj = $1; ###
     print ">$woj:", $T{"$tmp[1]$tmp[2]"}, " not found ($tmp[1]$tmp[2])\n";
     $Missing{$woj}++;
  }
}

print "*** $r found\n";

for $w (sort keys %Missing) { print "$Woj{$w} = $Missing{$w}\n"; }

close (O);

