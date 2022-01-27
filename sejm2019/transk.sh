#!/bin/bash
join_csvs.pl -fs1 0 -fn1 gminy_area_pop_PL_CC.csv -fs2 12 -fn2 kandydaci_sejm.csv > /tmp/kandydaci_sejm_00.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia" > kandydaci_sejm_cc.csv
csv_cols.pl -fs 0,1,2,9,11,13,14,16,19,20,21,22,27 /tmp/kandydaci_sejm_00.csv >> kandydaci_sejm_cc.csv 
### tylko duże komitety
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia" > kandydaci_sejm_cc00.csv
awk -F ';' '$8 ~ /(PiS|KOBW|SLD|PSL|KONFEDERACJA|BZPS)/ {print}' kandydaci_sejm_cc.csv >> kandydaci_sejm_cc00.csv

### kandydaci_sejm_cc00.csv ### wszyscy z dużych komitetów
### kandydaci_sejm_CC00.csv ### wszyscy z dużych komitetów (with jitter)
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC00.csv
csv_jitterGeo.pl -sep ',' -col 4 kandydaci_sejm_cc00.csv >> kandydaci_sejm_CC00.csv

### kandydaci_sejm_CCKK.csv ### wszyscy z dużych komitetów (kobiety)
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CCkk.csv
awk -F ';' '$12 ~ /K/ {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CCkk.csv

### duże komitety okręgi /25/26/34 (elbląg)
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CCnn.csv
awk -F ';' '$6 == 25 || $6 == 26 || $6 == 34 {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CCnn.csv

### duże komitety 1--5 na liscie
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC55.csv
awk -F ';' '$9 <6 {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CC55.csv

### 
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_cc00GD.csv
awk -F ';' '$6 == 25 {print }' kandydaci_sejm_CC00.csv > kandydaci_sejm_cc00GD.csv

echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_cc00SL.csv
awk -F ';' '$6 == 26 {print }' kandydaci_sejm_CC00.csv > kandydaci_sejm_cc00SL.csv

## Komitety
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PIS.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PIS5.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PISk.csv
awk -F ';' '$8 == "PiS" {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CC_PIS.csv
awk -F ';' '$9 <6 {print }' kandydaci_sejm_CC_PIS.csv >> kandydaci_sejm_CC_PIS5.csv
awk -F ';' '$8 == "PiS" {print }' kandydaci_sejm_CCkk.csv >> kandydaci_sejm_CC_PISk.csv

echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_KO.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_KO5.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_KOk.csv
awk -F ';' '$8 == "KOBW" {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CC_KO.csv
awk -F ';' '$9 <6 {print }' kandydaci_sejm_CC_KO.csv >> kandydaci_sejm_CC_KO5.csv
awk -F ';' '$8 == "KOBW" {print }' kandydaci_sejm_CCkk.csv >> kandydaci_sejm_CC_KOk.csv

echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PSL.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PSL5.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_PSLk.csv
awk -F ';' '$8 == "PSL" {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CC_PSL.csv
awk -F ';' '$9 <6 {print }' kandydaci_sejm_CC_PSL.csv >> kandydaci_sejm_CC_PSL5.csv
awk -F ';' '$8 == "PSL" {print }' kandydaci_sejm_CCkk.csv >> kandydaci_sejm_CC_PSLk.csv

echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_SLD.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_SLD5.csv
echo "teryt;xteryt;gmina;typ;coord;onum;oname;komitet;nrk;nz;im;plec;partia;xcoord" > kandydaci_sejm_CC_SLDk.csv
awk -F ';' '$8 == "SLD" {print }' kandydaci_sejm_CC00.csv >> kandydaci_sejm_CC_SLD.csv
awk -F ';' '$9 <6 {print }' kandydaci_sejm_CC_SLD.csv >> kandydaci_sejm_CC_SLD5.csv
awk -F ';' '$8 == "SLD" {print }' kandydaci_sejm_CCkk.csv >> kandydaci_sejm_CC_SLDk.csv

## Zamien na KML
rm PIS.kml KO.kml SLD.kml PSL.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_cc00SL.csv -out kml -icon 60 > SL.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_cc00GD.csv -out kml -icon 60 > SL.kml
##
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PIS.csv -out kml -icon 49 > PIS.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_KO.csv -out kml -icon 24 > KO.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_SLD.csv -out kml -icon 57 > SLD.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PSL.csv -out kml -icon 60 > PSL.kml
##
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PIS5.csv -out kml -icon 49 > PIS5.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_KO5.csv -out kml -icon 24 > KO5.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_SLD5.csv -out kml -icon 57 > SLD5.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PSL5.csv -out kml -icon 60 > PSL5.kml
##
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PISk.csv -out kml -icon 49 > PISk.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_KOk.csv -out kml -icon 24 > KOk.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_SLDk.csv -out kml -icon 57 > SLDk.kml
csv2gpx.pl -name 9,10,12 -desc 2,7,6 -llsep ' ' -latlon 13 kandydaci_sejm_CC_PSLk.csv -out kml -icon 60 > PSLk.kml

rm /tmp/kandydaci*csv
