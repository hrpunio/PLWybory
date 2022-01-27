while (<>) {
  chomp();
  if (/TERYT/i) { next}
  my ($id, $teryt, $nrk, $nzl, $nr, $kto, $glosy) =  split /;/, $_;
  $G{"$teryt;$nrk"}{"$nzl"} += $glosy;
  $T{"$teryt;$nrk"} += $glosy;
  $L{"$nzl"}=1;
  $ID{"$teryt;$nrk"}=$id;
}

print "id;teryt;nrk;";
for $l (sort keys %L) {  print "$l;"}
print "\n";


for $t (sort  keys %T) {
        printf "%s;%s;", $ID{$t}, $t;
   for $l (sort keys %L) {
      if ($T{$t} > 0 ) {
        printf "%.2f;", $G{$t}{$l}/$T{$t} * 100;
      } else {
        printf "0;\n";
      }
   }
   print "\n";
}

