#!/bin/bash

export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='raw'
export host='192.168.1.223:9002'

a=0
c='r50'

for filename in $(ls *.mp3); do


	for i in {1..5}; do
	        cp $filename  /tmp/output/${c}${a}${i}.mp3
                resource="/${bucket}/${c}${a}${i}.mp3"
		content_type="application/octet-stream"
		date=`date -R`
		_signature="PUT\n\n${content_type}\n${date}\n${resource}"
		signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

		curl -v -X PUT -T "${filename}" \
		          -H "Host: $host" \
		          -H "Date: ${date}" \
		          -H "Content-Type: ${content_type}" \
		          -H "Authorization: AWS ${s3_key}:${signature}" \
		          http://$host${resource} \
                &
	 	rm /tmp/output/${c}${a}${i}.mp3

        done;
        a=$((a+1)) 
#    mosquitto_pub -h 172.17.65.205 -f $filename -t yolo2
 #    echo "$filename published to mqtt"
  #   rm $filename
   # curl -i -H "name:$filename" --data-binary  @$filename -X POST  http://192.168.1.249:8001/contentListener
done;



