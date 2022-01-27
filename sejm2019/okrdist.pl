#!/usr/bin/perl
use Geo::Distance;
use Date::Calc qw(Day_of_Week);
my $geo = new Geo::Distance;

open (OKR, "okr.csv");

while (<OKR>) {
  chomp();
  ($nr,$name,$coords) = split /;/, $_;
   $Okr{$nr} = $coords;
   $OkrName{$nr} = $name;
  $okrNN++;
}

close(OKR);

print STDERR "$okrNN\n";

open (K, "kandydaci_sejm_cc.csv");
# 022502;1;Zgorzelec;gm;51.1517745,15.017122;1;Legnica;PiS;14;BUCIUTO;Jadwiga Barbara;Kobieta;PiS
# teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord
while (<K>) { 
    chomp();
    ($teryt, $xteryt, $gmina, $typ, $coord, $onum, $oname, $komitet, $nrk, $nz, $im, $plec, $partia) = split /;/, $_;
    ($lat, $lon) = split ",", $coord;
    ($olat, $olon) = split ",", $Okr{$onum};
    ##print STDERR "$lat, $lon => $olat, $olon [$onum]\n";
    $dist = $geo->distance( "meter", $lon, $lat => $olon, $olat );
    if ($dist > 299000) { printf "==> %.1f $OkrName{$onum} <- $gmina ==> $_\n", $dist/1000;    }
    $Komitet{$komitet} += $dist;
    $Partia{$partia} += $dist;
    $PartiaNN{$partia}++;
    $KomitetNN{$partia}++;
}

for $p (sort keys %Partia) { $sr = $Partia{$p}/$PartiaNN{$p}/1000; print "$p = $sr = $Partia{$p} $PartiaNN{$p}\n"; }
