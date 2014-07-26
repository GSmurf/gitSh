#!/bin/bash                                                                                                                                                   

# Date 1
dt1="2014-07-26 14:01:11"
# Compute the seconds since epoch for date 1
t1=$(date --date="$dt1" +%s)

# Date 2 : Current date
dt2=$(date +%Y-%m-%d\ %H:%M:%S)
# Compute the seconds since epoch for date 2
t2=$(date --date="$dt2" +%s)

let "diff=$t2-$t1"

echo "Date time t2 - t1 en secondes = $diff"
if [ $diff < 60 ]
then
	echo "oui"
else
	echo "non"
fi

