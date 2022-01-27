#!/bin/bash
awk -F ';' 'BEGIN{OFS=";"}; $2 ~ /14650|14651/ { $2="146501"; print $0; next}; {print $0}' ws2014_komisje.csv >  ws2014_komisje_DWawa.csv
