#!/usr/bin/perl 
#
open (IDS,"teryt_powiaty_BB.csv");

while (<IDS>) { chomp();
   ($nazwa, $teryt, $srodek, $bb) = split /;/, $_;
   $T2S{"$teryt"} = $srodek;
}
close(IDS);
## ## ##
open (COORDS, "powiaty_korelacje_pgnw_poparcie.csv");

while (<COORDS>) { chomp();
  @tmp = split /;/, $_;
  $id = $tmp[0];
  if ( exists $T2S{$id} ) { print "$_;$T2S{$id}\n"; }
  else { print "$_;NA\n";  warn "$id not found\n"}
}

close(COORDS);
