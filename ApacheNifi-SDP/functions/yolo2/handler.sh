
#!/bin/bash

export nano=`date +%s%N`

export OUT=/tmp/$nano.jpg

while IFS='=' read -r -d '&' key value; do
  case $key in
    image)
      IMAGE=$value
      ;;
   esac
done <<EOF
${Http_Query}&
EOF

cat - > ${OUT}

cd /darknet
 
./darknet detect cfg/yolov3.cfg yolov3.weights "${OUT}" -out  "/tmp/$IMAGE" > /tmp/output.txt

mosquitto_pub -h 172.17.65.205  -f /tmp/output.txt -t yoloOut
rm ${OUT}
#curl -i -H "name:$IMAGE" --data-binary  @/tmp/$IMAGE.png  -X POST  http://192.168.1.249:8002/inserted


