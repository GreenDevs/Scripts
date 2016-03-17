#!/bin/bash

#### THIS SCRIPT TRIES TO SIMULATE STOP WATCH

clear
time=0;

while true ; do
	echo ${time};
	sleep $((1/1000));
	time=`echo "$time + 0.001" | bc`
	clear
done

