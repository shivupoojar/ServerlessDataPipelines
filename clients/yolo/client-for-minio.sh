#!/bin/bash


export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='raw'
export host='192.168.1.223:9002'

for i in {1..1}; do
   cp ~/office.mp4 /tmp/output/r${i}.mp4
done;
cd /tmp/output
for filename in $(ls *.mp4); do
       # mosquitto_pub -h 192.168.1.249  -f ${filename} -t ffmpeg -q 2
	echo `date`
        echo ${filename}
   #    rm ${filename}
#        a=`echo ${filename:12:2}`
        curl -X POST --data-binary @/tmp/output/${filename}  http://192.168.1.223:8080/function/mqtt-ffmpeg
#	echo ${filename}
       rm ${filename}
done;


#for filename in $(ls *.mp4); do

#	resource="/${bucket}/${filename}"
#	content_type="application/octet-stream"
#	date=`date -R`
#	_signature="PUT\n\n${content_type}\n${date}\n${resource}"
#	signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`
#
#	curl -v -X PUT -T "${filename}" \
#	          -H "Host: $host" \
#	          -H "Date: ${date}" \
#	          -H "Content-Type: ${content_type}" \
#	          -H "Authorization: AWS ${s3_key}:${signature}" \
#	          http://$host${resource}
#	rm ${filename}
#done








