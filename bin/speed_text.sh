#!/bin/bash

timestamp=$(date '+%Y%m')
csv_file="log/speed_$timestamp.csv"
mkdir -p 'log'

./bin/speedtest_cli.py | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file
#cat ./test.log | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file

gnuplot << eor

 set output 'connection_speed_$timestamp.png'

 set terminal png size 900, 300
 set obj 1 rectangle behind from screen 0,0 to screen 1,1
 set obj 1 fillstyle solid 1.0 fillcolor rgbcolor "black"

 set title "connection speed" textcolor rgbcolor "white"
 set key textcolor rgbcolor "white"
 set border linecolor rgbcolor "white"
 set ylabel "Mbps" textcolor rgbcolor "white"
 set xlabel "timestamp" textcolor rgbcolor "white"

 set datafile separator ","

 set xdata time
 set timefmt "%Y%m%d%H%M"

 set style line 1 lc rgb "blue"
 set style line 2 lc rgb "green"

 plot "$csv_file" using 1:2 with line title "download" ls 1, "$csv_file" using 1:3 with line title "upload" ls 2

eor

#  set boxwidth 0.5
#  set style fill solid
