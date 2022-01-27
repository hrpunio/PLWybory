use utf8;
binmode(STDOUT, ":utf8");
use Getopt::Long;
use open ":encoding(utf8)";


open (OLD, "Kandydaci_2015.csv");

while (<OLD>) {
   @tmp = split /;/; $_;

   $kto = lc("$tmp[4]");
   $kto =~ s/ //g;
   $Kto{"$kto"}++;
   $KtoOkr{$kto}="$tmp[0]"; ## nr okręgu
   if ( $Kto{$kto} > 1 ) { print STDERR "** potencjalne sobowtóry => $Kto{$kto}\n"; }
}

close(OLD);

open (NEW, "kandydaci_sejm_cc.csv");

print "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;ret;onumo\n";

while (<NEW>) { chomp();
   ##@tmp = split /;/, $_;
   # 146513;1;Mst Warszawa (a);mm;52.233002,21.0614195;1;Legnica;PiS;1;LIPIŃSKI;Adam Józef;Mężczyzna;PiS
   ($teryt, $xteryt, $gmina, $typ, $coord, $onum, $oname, $komitet, $nrk, $nz, $im, $plec, $partia) = split /;/, $_;

   $kto = lc("$im $nz");
   $truekto = $kto;
   $kto =~ s/ //g;

   if ( defined $Kto{$kto} ) {## ## ##
      if ( defined $KtoOkr{$kto} ) { $oldOkr="$KtoOkr{$kto}"; } 
     $Ret{$partia}++; $ret = "1"; $retNN++ } 
   else { $Zet{$partia}++; $ret = "0"; $retZZ--; 
     $oldOkr ="-1"; }
   if ( $oldOkr > 0 ) {
      if ( $oldOkr == $onum ) { $qq ="${oldOkr}==$onum" } 
      else {  $qq ="${oldOkr}=>$onum"}
   }
   else {$qq = '';}
   print "$_;[$ret];$oldOkr;$qq\n";

   if ($nrk < 6) {
     if ( defined $Kto{$kto} ) { $Ret5{$partia}++; $ret5 = "1"; $ret5NN++ } else { $Zet5{$partia}++; $ret5 = "0"; $ret5ZZ-- }
   }
   if ($nrk < 4) {
     if ( defined $Kto{$kto} ) { $Ret3{$partia}++; $ret3 = "1"; $ret3NN++ } else { $Zet3{$partia}++; $ret3 = "0"; $ret3ZZ-- }
   }

}

close(NEW);

for $p (sort { $Ret{$b} <=> $Ret{$a} } keys %Ret) {
  $c = $Ret{$p}/($Ret{$p} + $Zet{$p}) * 100;
  printf "%s %i %i %.1f\n", $p, $Ret{$p}, $Zet{$p}, $c;
}

print "=:=:=:=:=:=:=:=:=\n";
for $p (sort { $Ret5{$b} <=> $Ret5{$a} } keys %Ret5) {
  $c = $Ret5{$p}/($Ret5{$p} + $Zet5{$p}) * 100;
  printf "%s %i %i %.1f\n", $p, $Ret5{$p}, $Zet5{$p}, $c;
}

print "=:=:=:=:=:=:=:=:=\n";
for $p (sort { $Ret3{$b} <=> $Ret3{$a} } keys %Ret3) {
  $c = $Ret3{$p}/($Ret3{$p} + $Zet3{$p}) * 100;
  printf "%s %i %i %.1f\n", $p, $Ret3{$p}, $Zet3{$p}, $c;
}

