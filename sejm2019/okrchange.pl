#!/usr/bin/perl
use Geo::Distance;
use Math::Complex;
use Math::Trig;

my $geo = new Geo::Distance;

open (OKR, "okr.csv");
while (<OKR>) { chomp();

  if (/siedziba;coord/ ) { next }  

  ($nr,$name,$coords) = split /;/, $_;
   $Okr{$nr} = $coords;
   $OkrName{$nr} = $name;
}

close(OKR);

open (K, "kandydaci_sejm_2019ret.csv");
while (<K>) { chomp();
    ($teryt, $xteryt, $gmina, $typ, $coord, $onum, $oname, $komitet, $nrk, $nz, $im, $plec, $partia, $ret, $onumo, $trans) = split /;/, $_;
    if ($trans =~ /=>/) {
       ($old, $new) = split /=>/, $trans;
       ($olat, $olon) = split ",", $Okr{$old}; ### old
       ($lat, $lon) = split ",", $Okr{$new}; ## new

       $old_oname = $OkrName{$old}; $new_oname = $OkrName{$new};

       $dist = $geo->distance( "meter", $lon, $lat => $olon, $olat );
       $distKm = $dist/1000;

       if ($distKm < 150.0) { next }

       ##print "$_;$distKm\n"; 

       ($lat, $lon) = jitter($lat, $lon);
       ($olat, $olon) = jitter($olat, $olon);

       if ($komitet =~ /(SLD|PiS|PSL|KONFEDERACJA|KOBW)/ ) {
        $KML{$komitet} .= ""
          . "<Placemark><styleUrl>#${komitet}_Q</styleUrl>"
          . "<name>$im $nz ${old_oname}-${new_oname}</name><Point><coordinates>$lon,$lat</coordinates></Point></Placemark>"
          ##. "<Placemark><styleUrl>#${komitet}_P</styleUrl>"
          ##. "<name>$im $nz $old_oname</name><Point><coordinates>$olon,$olat</coordinates></Point></Placemark>\n"
          . "<Placemark><styleUrl>#${komitet}_L</styleUrl><name>$im $nz ${old_oname}-${new_oname}</name><LineString><tessellate>1</tessellate><coordinates>"
          . "$lon,$lat $olon,$olat</coordinates></LineString></Placemark>\n";
        $moving++;
       }
    }
}
####

for $o (sort { $a <=> $b } keys %Okr) {
  ($lat, $lon) = split ",", $Okr{$o};
  $KMLxx .= "<Placemark><styleUrl>#Okr</styleUrl>"
    . "<name>Okr $o</name><Point><coordinates>$lon,$lat</coordinates></Point></Placemark>"
}

#### https://www.colorhexa.com/ffff00
$gURL="http://maps.google.com/mapfiles/kml/paddle";
 print "<?xml version='1.0' encoding='UTF-8'?>\n"
   . "<kml xmlns='http://www.opengis.net/kml/2.2' xmlns:gx='http://www.google.com/kml/ext/2.2'>\n"
   . "<Document>\n<name>kml</name>\n"
   . "<description>tomasz przechlewski, http://pinkaccordions.homelinux.org. Some rights reserved (CC BY 2.0)</description>\n"
###########
   . "<Style id='PiS_P'><IconStyle><Icon><href>$gURL/purple-square-lv.png</href></Icon></IconStyle></Style>\n" ## purple
   . "<Style id='SLD_P'><IconStyle><Icon><href>$gURL/red-circle-lv.png</href></Icon></IconStyle></Style>\n"    ## red
   . "<Style id='PSL_P'><IconStyle><Icon><href>$gURL/grn-blank-lv.png</href></Icon></IconStyle></Style>\n"     ## green
   . "<Style id='KOBW_P'><IconStyle><Icon><href>$gURL/blu-blank-lv.png</href></Icon></IconStyle></Style>\n"    ## blue
   . "<Style id='KONFEDERACJA_P'><IconStyle><Icon><href>$gURL/ylw-blank-lv.png</href></Icon></IconStyle></Style>\n" ## yellow
   . "<Style id='PiS_Q'><IconStyle><Icon><href>$gURL/purple-blank.png</href></Icon></IconStyle></Style>\n" ## purple
   . "<Style id='SLD_Q'><IconStyle><Icon><href>$gURL/red-circle.png</href></Icon></IconStyle></Style>\n"    ## red
   . "<Style id='PSL_Q'><IconStyle><Icon><href>$gURL/grn-blank.png</href></Icon></IconStyle></Style>\n"     ## green
   . "<Style id='KOBW_Q'><IconStyle><Icon><href>$gURL/blu-blank.png</href></Icon></IconStyle></Style>\n"    ## blue
   . "<Style id='KONFEDERACJA_Q'><IconStyle><Icon><href>$gURL/ylw-blank.png</href></Icon></IconStyle></Style>\n" ## yellow
   ############
   . "<Style id='Okr'><IconStyle><Icon><href>http://maps.google.com/mapfiles/kml/pal4/icon53.png</href></Icon></IconStyle></Style>\n"
   #############
   . "<Style id='PiS_L'><LineStyle><color>ff800080</color><width>1</width></LineStyle></Style>\n" ## purple
   . "<Style id='SLD_L'><LineStyle><color>ff0000ff</color><width>1</width></LineStyle></Style>\n"
   . "<Style id='PSL_L'><LineStyle><color>ff00ff00</color><width>1</width></LineStyle></Style>\n"
   . "<Style id='KOBW_L'><LineStyle><color>ffff0000</color><width>1</width></LineStyle></Style>\n"
   . "<Style id='KONFEDERACJA_L'><LineStyle><color>ff00ffff</color><width>1</width></LineStyle></Style>\n";

for $k (sort keys %KML ) { print "$KML{$k}\n"; }
print $KMLxx; ### 
print "<!-- $moving -->\n";
print "</Document></kml>\n";


sub jitter {
   my $lat = shift;
   my $lon = shift;

   my $factor = 0.05;
   my $pi = 4*atan2(1,1);
   my $sd = sqrt($factor);

   my $r = $sd * sqrt(rand()); $theta = rand() * 2 * $pi;

   my $rand_lat = $lat + $r * cos($theta);
   my $rand_lon = $lon + $r * sin($theta);

   return ($rand_lat, $rand_lon);
}
