#!/bin/bash

relative_path=$(dirname ${BASH_SOURCE})

output_path=$1
mkdir -p $output_path

timestamp=$(date '+%Y%m')
csv_file="$output_path/speed_$timestamp.csv"

gnuplot << eor
 set output '$output_path/connection_speed_$timestamp.png'

 set terminal png size 900, 300
 set obj 1 rectangle behind from screen 0,0 to screen 1,1
 set obj 1 fillstyle solid 1.0 fillcolor rgbcolor "black"

 set title "connection speed" textcolor rgbcolor "white"
 set key outside horizontal bmargin textcolor rgbcolor "white"
 set border linecolor rgbcolor "white"
 set ylabel "Mbps" textcolor rgbcolor "white"
# set xlabel "timestamp" textcolor rgbcolor "white"

 set datafile separator ","

 set xdata time
 set timefmt "%Y%m%d%H%M"
 set yrange [0:*]

 set style line 1 lc rgb "blue"
 set style line 2 lc rgb "green"

 plot "$csv_file" using 1:3 with line title "↑" ls 2, "$csv_file" using 1:2 with line title "↓" ls 1
eor

open $output_path/connection_speed_$timestamp.png
