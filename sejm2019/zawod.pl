$limit =20 ;

while (<>) {
  chomp();
  ## Komitet;Typ;Pozycja;Nazwisko;Imiona;Plec;Partia;Zawod
  ($komitet, $typk, $poz, $nz, $im, $plec, $partia, $zawod) = split /;/, $_;
  $Zawod{$zawod}++;
  $total++;
  if ($plec =~ /^K/) {$ZawodK{$zawod}++; $totalK++; }
  $ZawodP{$partia}{$zawod}++;
  $ZawodPNN{$partia}++;
  if ($poz < 6 ) {$Zawod5{$zawod}++; $total5++; }
}

print "========= ogółem =============\n";
for $z (sort { $Zawod{$b} <=> $Zawod{$a} } keys %Zawod ) { $o++;
   printf "W: %s %i %.1f\n", $z, $Zawod{$z}, $Zawod{$z}/$total *100;
   if ($o > $limit ) { last } 
}

   print "========= 1--5 =============\n";
$o =0;

for $z (sort { $Zawod5{$b} <=> $Zawod5{$a} } keys %Zawod5 ) { $o++;
   printf "W: %s %i %.1f\n", $z, $Zawod5{$z}, $Zawod5{$z}/$total5 *100;
   if ($o > $limit ) { last } 
}

   print "========= kobiety =============\n";
$o = 0;

for $z (sort { $ZawodK{$b} <=> $ZawodK{$a} } keys %ZawodK ) { $o++;
   printf "K: %s %i %.1f\n", $z, $ZawodK{$z}, $ZawodK{$z}/$totalK *100;
   if ($o > $limit ) { last } 
}

   print "========= partie =============\n";

$o=0;

for $p (sort keys %ZawodP ) { $o=0;
   if ($ZawodPNN{$p} < 100 ) { next; }
   print "========= $p =============\n";
   for $z (sort { $ZawodP{$p}{$b} <=> $ZawodP{$p}{$a} }  keys %{$ZawodP{$p}} ) { $o++;
     printf "P $p: %s %i %.1f\n", $z, $ZawodP{$p}{$z}, $ZawodP{$p}{$z}/$ZawodPNN{$p} *100;
     if ($o > $limit ) { last } 
   }
}




