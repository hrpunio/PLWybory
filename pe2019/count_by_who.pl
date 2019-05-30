while (<>) {
  chomp();
  my ($id, $teryt, $nrk, $nzl, $nr, $kto, $glosy) =  split /;/, $_;
  $G{"$kto;$nzl"} += $glosy;
}

for $k (sort { $G{$b} <=> $G{$a} } keys %G) {
   $lp++;
   print "$lp;$G{$k};$k\n"
}

