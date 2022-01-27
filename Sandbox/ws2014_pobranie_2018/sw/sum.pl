while (<>) {chomp();
 @tmp = split /;/;

 $K{$tmp[0]}++;

}

for $k (keys %K) {
    print "$k $K{$k}\n";
}
