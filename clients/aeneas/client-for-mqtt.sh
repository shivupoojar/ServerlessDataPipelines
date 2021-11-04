#!/bin/bash

a=0
c='r30'

for filename in $(ls *.mp3); do


	for i in {1..30}; do
	        cp $filename  /tmp/output/${c}${a}${i}.mp3
                mosquitto_pub -h 192.168.1.249  -f ${filename}  -t aeneas -q 2
                echo /tmp/output/${c}${a}${i}.mp3
                echo `date +"%Y-%m-%d %T.%N"`
	 	rm /tmp/output/${c}${a}${i}.mp3

        done;
        a=$((a+1)) 
#    mosquitto_pub -h 172.17.65.205 -f $filename -t yolo2
 #    echo "$filename published to mqtt"
  #   rm $filename
   # curl -i -H "name:$filename" --data-binary  @$filename -X POST  http://192.168.1.249:8001/contentListener
done;



