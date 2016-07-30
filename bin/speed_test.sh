#!/bin/bash

relative_path=$(dirname ${BASH_SOURCE})

output_path=$1
mkdir -p $output_path

timestamp=$(date '+%Y%m')
csv_file="$output_path/speed_$timestamp.csv"

$relative_path/speedtest_cli.py | grep -E "(Download|Upload)" | tr '\n' ' ' | awk -v date=$(date '+%Y%m%d%H%M') '{print date "," $2 "," $5}' >> $csv_file
