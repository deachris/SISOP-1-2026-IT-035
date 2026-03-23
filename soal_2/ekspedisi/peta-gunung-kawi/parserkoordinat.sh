#!/bin/bash

awk -F'[:,]' '
/"id"/ {id=$2}
/"site_name"/ {site_name=$2}
/"latitude"/ {latitude=$2}
/"longitude"/ {longitude=$2; print id "," site_name ","  latitude "," longitude}
' gsxtrack.json | sed 's/[ "]*//g' >> titik-penting.txt


