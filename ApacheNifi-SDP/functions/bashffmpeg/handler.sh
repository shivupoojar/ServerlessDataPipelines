111#!/bin/sh

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
ffmpeg -loglevel info -nostats -i ${OUT}  -vf fps=15  "${name}_%03d.jpg" < /dev/null
tar cf - *.jpg 
#find -name "*.jpg" | xargs tar cf - -T 
rm ${OUT}
rm *.jpg
#for filename in $(ls *.jpg); do

 #   curl -i -H "name:$filename" --data-binary  @$filename -X POST  http://192.168.1.249:8001/contentListener
    
#done


