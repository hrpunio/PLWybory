open (O, "kandydaci_listy.csv");

while (<O>) { chomp();  @tmp=split /;/, $_; $K{$tmp[0]} = $_;}

##

while (<>) { chomp();
  @tmp = split /;/, $_;

  if (exists $K{$tmp[1]} ) {
     print "$_;==;$K{$tmp[1]}\n";
  } else { print STDERR "**** problem with $tmp[1]!\n"; }
}


##
