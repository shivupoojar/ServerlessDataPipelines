#!/bin/bash

export nano=`date +%s%N`

export OUT=/tmp/$nano.wav
export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='pocketsphinx'
export host='192.168.1.223:9002'

while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF


cat - > ${OUT}
pocketsphinx_continuous -infile ${OUT} -logfn a.txt > /tmp/${name}.txt
#mosquitto_pub -h 172.17.67.176  -f /tmp/output.txt -t textsearch 
cd /tmp 

filename=${name}.txt
resource="/${bucket}/${filename}"
content_type="application/octet-stream"
date=`date -R`
_signature="PUT\n\n${content_type}\n${date}\n${resource}"
signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`

curl -v -X PUT -T "${filename}" \
          -H "Host: $host" \
          -H "Date: ${date}" \
          -H "Content-Type: ${content_type}" \
          -H "Authorization: AWS ${s3_key}:${signature}" \
          http://$host${resource}
cd ..
rm ${OUT}
rm /tmp/${name}.txt


