#!/bin/bash

csv_file="log/speed_$(date '+%Y%m%d%H%M').csv"
mkdir -p 'log'

./bin/speedtest_cli.py | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file
#cat ./test.log | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file

gnuplot << eor

 set terminal png size 900, 300
 set output 'out.png'

 set datafile separator ","

 set xdata time
 set timefmt "%Y%m%d"

 plot "sample.csv" using 1:2 with line

eor

#  set boxwidth 0.5
#  set style fill solid
