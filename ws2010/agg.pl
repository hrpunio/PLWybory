#!/usr/bin/perl
%Komitety = ('PSL' => 2, 'PO' => 4, 'PiS' => 5, 'SLD' => 1);

while (<>) { chomp();
  ($terytP, $obwod, $nr, $okreg, $obwodW, $nrk, $komitet, $kandydat, $glosy) = split /;/, $_;
  $GlosyK{$nr}{$komitet} += $glosy;
  $GlosyR{$nr} += $glosy;
  $Teryt{$nr} = "$terytP;$nr";

 }

## ## ## ##
print "terytP;nrk;";

for $k (sort keys %Komitety) { print "$k;" }
for $k (sort keys %Komitety) { print "${k}p;" }

print "totalG\n";

## ## ## ##
for $n (keys %GlosyK) {

   print $Teryt{$n} . ";";

   for $k (sort keys %Komitety) {
      if ($GlosyR{$n} > 0 ) {
      print $GlosyK{$n}{$k} . ";";
      } else { print "NA;"}
   }
   for $k (sort keys %Komitety) {
      if ($GlosyR{$n} > 0 ) {
      printf "%.2f;", $GlosyK{$n}{$k} / $GlosyR{$n} * 100;
      } else { print "NA;"}
   }
   print ";$GlosyR{$n}\n"
}
