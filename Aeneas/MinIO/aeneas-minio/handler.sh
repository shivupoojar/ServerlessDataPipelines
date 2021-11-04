#!/bin/bash

# Create a temporary filename
export nano=`date +%s%N`

export OUT=/tmp/$nano.mp3
export s3_key='AKIAIOSFODNN7EXAMPLE'
export s3_secret='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
export bucket='aeneas'
export host='192.168.1.223:9002'


while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF

cat - > ${OUT}

#export file=`echo 'p00'`echo $((1 +  RANDOM % 3 ))`.xhtml`

a=`echo $((1 +  RANDOM % 2 ))`

export file=`echo 'p00'$a.xhtml`

echo $file
curl -d $file http://192.168.1.223:8080/function/getobject > /tmp/$file

python -m aeneas.tools.execute_task \
   ${OUT} \
   /tmp/$file \
   "task_language=eng|os_task_file_format=json|is_text_type=plain" \
  /tmp/${name}.json  > /tmp/output.txt 

#echo ${nano}.json
cd /tmp/
filename=${name}.json
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



rm  ${OUT}
rm /tmp/$file
rm /tmp/${file:0:4}.json
