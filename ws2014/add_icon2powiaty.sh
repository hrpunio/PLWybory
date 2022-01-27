#!/bin/bash
cat powiaty_korelacje_pgnw_poparcie_coords.csv |
perl gft_add_icon.pl -c 1 -sb -1.0,-0.4,-0.2,0.0,0.2,0.4  | \
perl gft_add_icon.pl -c 2 -sb -1.0,-0.4,-0.2,0.0,0.2,0.4  | \
perl gft_add_icon.pl -c 3 -sb -1.0,-0.4,-0.2,0.0,0.2,0.4  | \
perl gft_add_icon.pl -c 4 -sb  0,10,12.5,15,17.5,20,22.5,25 | \
perl gft_add_icon.pl -c 4 -sb  0,10,15,20,25,30  > qq.csv
