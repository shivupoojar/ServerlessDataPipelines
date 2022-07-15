#!/bin/bash

export nano=`date +%s%N`

export OUT=/tmp/$nano.jpg
export IMAGE=$nano
export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='yololess'
export bucket2='yolotextoutput'
export host='192.168.1.223:9002'

#while IFS='=' read -r -d '&' key value; do
#  case $key in
#    image)
#      IMAGE=$value
#      ;;
#   esac
#done <<EOF
#${Http_Query}&
#EOF
while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF

cat - > ${OUT}

cd /darknet
echo "Image Name:"
echo ${name} 
./darknet detect cfg/yolov3.cfg yolov3.weights "${OUT}" -out "/tmp/${name}_${IMAGE}" > /tmp/${name}_${IMAGE}.txt


#resource="/${bucket}/${name}.png"#
#content_type="application/octet-stream"
#date=`date -R`
#_signature="PUT\n\n${content_type}\n${date}\n${resource}"
#signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`
#curl -v -X PUT -T "/tmp/${IMAGE}.png" \
#	          -H "Host: $host" \
#	          -H "Date: ${date}" \
#	          -H "Content-Type: ${content_type}" \
#	          -H "Authorization: AWS ${s3_key}:${signature}" \
#	          http://$host${resource}
resource="/${bucket2}/${name}_${IMAGE}.txt"
content_type="application/octet-stream"
date=`date -R`
_signature="PUT\n\n${content_type}\n${date}\n${resource}"
signature=`echo -en ${_signature} | openssl sha1 -hmac ${s3_secret} -binary | base64`
curl -v -X PUT -T "/tmp/${name}_${IMAGE}.txt" \
	          -H "Host: $host" \
	          -H "Date: ${date}" \
	          -H "Content-Type: ${content_type}" \
	          -H "Authorization: AWS ${s3_key}:${signature}" \
	          http://$host${resource}

