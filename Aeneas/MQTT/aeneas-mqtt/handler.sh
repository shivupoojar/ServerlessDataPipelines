#!/bin/bash

# Create a temporary filename
export nano=`date +%s%N`

export OUT=/tmp/$nano.mp3


cat - > ${OUT}

#export file=`echo 'p00'`echo $((1 +  RANDOM % 3 ))`.xhtml`

a=`echo $((1 +  RANDOM % 2 ))`

export file=`echo 'p00'$a.xhtml`

curl -d $file http://192.168.1.223:8080/function/getobject > /tmp/$file

python -m aeneas.tools.execute_task \
   ${OUT} \
   /tmp/$file \
   "task_language=eng|os_task_file_format=json|is_text_type=plain" \
  /tmp/${file:0:4}.json  > /tmp/output.txt 
rm  ${OUT}
rm /tmp/$file
mosquitto_pub -h 192.168.1.249  -f /tmp/${file:0:4}.json -t tocloud -q 2
#curl -d @/tmp/${file:0:4}.json  http://192.168.1.223:8080/function/publish-mqtt
#cat /tmp/${file:0:4}.json
#rm  /tmp/$IMAGE.json
rm /tmp/${file:0:4}.json
