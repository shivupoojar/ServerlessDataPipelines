
#!/bin/sh

# Create a temporary filename
export nano=`date +%s%N`

export OUT=/tmp/$nano.mp4
export result=$nano

# Save stdin to a temp file


while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF

cat - > ${OUT}
ffmpeg -loglevel info -nostats -i ${OUT}  -vf fps=${name} "${name}_%03d.jpg" < /dev/null

#tar -cOvfz $name.tar.gz  *.jpg pipe:1
ls -l 
for filename in $(ls *.jpg); do
     mosquitto_pub -h 172.17.65.205 -f $filename -t yolo2
     echo "$filename published to mqtt"
     rm $filename
 #   curl -i -H "name:$filename" --data-binary  @$filename -X POST  http://192.168.1.249:8001/contentListener
    
done

rm ${OUT}

