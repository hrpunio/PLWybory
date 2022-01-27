#!/usr/bin/perl
use open ":encoding(utf8)";
use open IN => ":encoding(utf8)", OUT => ":utf8";
binmode(STDOUT, ":utf8");

while (<>) {
  chomp();
  if (/komitet/) { print "$_\n"; next }
  ## rok;nr_okr;nr_k;komitet;kandydat;glosy;procent_okr;procent_lista;plec;wynik
  ($rok, $nr_okr, $nr_k, $komitet, $kandydat, $glosy, $procent_okr, $procent_lista, $plec, $wynik) = split /;/, $_;

  @tmp = split / /, $kandydat;
  $tmp[0] = uc($tmp[0]);
  $kandydat = "@tmp";
  $procent_lista =~ s/,/./g;
  $procent_okr =~ s/,/./g;

  printf "%i;%i;%i;%s;%s;%i;%.2f;%.2f;%s;%s\n",
  $rok, $nr_okr, $nr_k, $komitet, $kandydat, $glosy, $procent_okr, $procent_lista, $plec, $wynik;

}
