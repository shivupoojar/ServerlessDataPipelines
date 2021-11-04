#!/bin/bash

for i in {1..10}; do
   cp ~/office.mp4 /tmp/output/v${i}.mp4
done;

for filename in $(ls /tmp/output/*.mp4); do
    #    mosquitto_pub -h 172.17.67.176  -f ${filename} -t aeneas
	echo `date`
        a=`echo ${filename:12:2}`
        curl -X POST --data-binary @${filename}  http://192.168.1.223:8080/function/mqtt-ffmpeg?${a} 
	echo ${filename}
done;



