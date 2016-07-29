#!/bin/bash

timestamp=$(date '+%Y%m')
csv_file="log/speed_$timestamp.csv"
mkdir -p 'log'

#./bin/speedtest_cli.py | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file
cat ./test.log | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file

cat $csv_file

gnuplot << eor

 set terminal png size 900, 300
 set output 'connection_speed_$timestamp.png'

 set title "connection speed"
 set ylabel "Mbps"
 set xlabel "timestamp"

 set datafile separator ","

 set xdata time
 set timefmt "%Y%m%d%H%M"

 plot "$csv_file" using 1:2 with line title "download", "$csv_file" using 1:3 with line title "upload"

eor

#  set boxwidth 0.5
#  set style fill solid
