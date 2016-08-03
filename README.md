# Connection Speed Monitor

Log internet connection speed to csv and generate graph reports

![example](https://raw.githubusercontent.com/ctracey/connection_speed_monitor/master/connection_speed_example.png)

## Requirements

 - gnuplot cli 
 `brew install gnuplot`

 - also speedtest_cli
https://github.com/sivel/speedtest-cli

scheduling http://www.splinter.com.au/using-launchd-to-run-a-script-every-5-mins-on/

## Running

To run speed test
`./bin/speedtest.sh <OUTPUT_FOLDER_PATH>`

To generate graph from csv log
`./bin/speedreport.sh <OUTPUT_FOLDER_PATH>`

## Scheduling

Up to you to schedule this to run in your own way

