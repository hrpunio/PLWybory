#!/usr/bin/perl
#
use Getopt::Long;
print STDERR ("*** $0 -c NUM -draft\n");


## measle_white 
## measle_gray
## measle_brown
## --measle_turquoise--
## small_yellow
## measle_purple
## small_blue
## small_red
GetOptions("c=i" => \$Col, "draft" => \$Draft, "sb=s" => \$ScaleTxt);

my %ScaleIcons = (
  1 => 'measle_white',
  2 => 'measle_grey', 
  3 => 'small_yellow', 
  4 => 'measle_brown', 
  5 => 'measle_turquoise', 
  6 => 'small_purple', 
  7 => 'small_blue', 
  8 => 'small_red', 
);

## LowTurout (Hojarska na przykład)
### https://fusiontables.google.com/DataSource?dsrcid=308519#map:id=3
my %DefaultScale = ( 
  0  => 'measle_white',
  10 => 'measle_grey', 
  15 => 'measle_brown', 
  20 => 'small_purple', 
  25 => 'small_blue', 
  30 => 'small_red', );

if ($ScaleTxt) {
   @scale_breaks = split /[;,:]/, $ScaleTxt;
 }

for $sb (@scale_breaks) {
  $row++;
  $MyScale{$sb} = $ScaleIcons{$row};
}

### Ustalenie skalo
my %Scale;
if ($ScaleTxt) { %Scale = %MyScale }
else { %Scale =  %DefaultScale }

@qq = sort {$a <=> $b} keys %Scale;
$qqN = $#qq +1;
print STDERR ("*** Scale Used: @qq ($qqN)\n");

## ### ###
$hdr = <>; chomp($hdr); print "$hdr;icon\n";

while (<>) { chomp();  @tmp = split /;/, $_; $val = $tmp[$Col];
  my $sb;
  for $scale_break (sort { $a <=> $b } keys %Scale ) {
     if ($val >= $scale_break ) { $sb = $scale_break; next } 
  }
  $icon = $Scale{$sb} ; 

  if ($Draft) {
     print "$icon;$val > $sb ($_)\n"; }
  else { print "$_;$icon\n";  }
}
