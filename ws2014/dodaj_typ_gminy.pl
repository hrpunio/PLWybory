#!/usr/bin/perl
open (T, "teryt_kody_typy.csv");

while (<T>) { chomp();
  ($teryt, $typ, $name) = split /;/, $_;
  ##print "$teryt\n";
  $Type{$teryt} = $typ;
}

close(T);

open (T, "komisje_komitety7_wyniki.csv");
while (<T>) { chomp();
  @tmp = split /;/, $_;
  if (exists  $Type{$tmp[1]}) { print "$_;$Type{$tmp[1]}\n" }
  else {print "$_;NA\n"; }
}
