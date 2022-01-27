#!/bin/bash
B="/home/tomek/Temp/2018X/"
S="2505"
cd $B
### Zapisz wynik ###
rm  H${S}.txt
for i in w*_${S}.html; do perl clean_2.pl $i >> H${S}.txt ; done
###
perl clean_3.pl  H${S}.txt > ws2018_${S}.tex
pdflatex ws2018_${S}.tex
convert -density 150 ws2018_${S}.pdf ws2018_${S}.jpg
