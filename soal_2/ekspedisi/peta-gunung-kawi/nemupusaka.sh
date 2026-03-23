#!/bin/bash

awk -F',' 'NR<=4 {latitude+=$3; longitude+=$4; count++}
END {print latitude/count "," longitude/count}' titik-penting.txt |
while IFS=',' read long lat; do
echo "Koordinat pusat:
($long, $lat)" >> posisipusaka.txt
done
