#!/usr/bin/perl
%Komitety = (###
## 'Patriotyczny' => '1', ##(Ruch patriotyczny)
## 'PPP' => '2', ## Polska Partia Pracy
 'LPR' => '3',
## 'DemokraciPL' => '4', ## d. UWole
## 'SDPL' => '5', ##(Socjaldemokracja Polska)
 'PiS' => '6',
 'SLD' => '7',
 'PO' => '8',
## 'PPN' => '9', ##(Polska Partia Narodowa)
 'PSL' => '10',
## 'Centrum' => '11', ## jakaś efemeryda
## 'JKM' => '12', ## JKM
## 'KObywatelska' => '13',
 'Samoobrona' => '15', 
## 'InicjatywaRP' => '16', ## efemeryda
## 'DomO' => '17', ## ditto (Dom Ojczysty) ##
## 'NOP' => '18', ## ditto 
);

while (<>) { chomp();
  ($teryt, $nro, $nrk, $komitet, $kandydat, $glosy) = split /;/, $_;

  $id = "$teryt:$nro";

  $GlosyK{$id}{$komitet} += $glosy;
  $GlosyR{$id} += $glosy;
  $Teryt{$id} = "$teryt:$nro";


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
