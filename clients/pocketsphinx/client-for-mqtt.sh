#!/bin/bash

export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='rawpocketsphinx'
export host='192.168.1.223:9002'

a=0
c='r10'
cd ~/pocketsphinx
for filename in $(ls *.wav); do


	for i in {1..10}; do
	        cp $filename  /tmp/output/${c}${a}${i}.wav
                mosquitto_pub -h 192.168.1.249 -f $filename -t pocketsphinx -q 2  
	 	echo /tmp/output/${c}${a}${i}.mp3
                echo `date +"%Y-%m-%d %T.%N"`
                rm /tmp/output/${c}${a}${i}.wav
 
        done;
        a=$((a+1)) 
#    mosquitto_pub -h 172.17.65.205 -f $filename -t yolo2
 #    echo "$filename published to mqtt"
  #   rm $filename
   # curl -i -H "name:$filename" --data-binary  @$filename -X POST  http://192.168.1.249:8001/contentListener
done;




