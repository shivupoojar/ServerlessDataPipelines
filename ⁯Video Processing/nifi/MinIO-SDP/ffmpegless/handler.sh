#!/bin/sh

# Create a temporary filename
export nano=`date +%s%N`

export OUT=/tmp/$nano.mp4
export result=$nano
export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='splitimages'
export host='192.168.1.223:9002'

# Save stdin to a temp file


while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF

cat - > ${OUT}
ffmpeg -loglevel info -nostats -i ${OUT} -vf fps=10 "${name}_%03d.jpg" < /dev/null

ls -l

for filename in $(ls *.jpg); do

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
	rm ${filename}
done











