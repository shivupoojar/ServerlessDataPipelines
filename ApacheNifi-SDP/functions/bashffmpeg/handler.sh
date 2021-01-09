111#!/bin/sh

# Create a temporary filename
export nano=`date +%s%N`

export OUT=/tmp/$nano.mp4
export result=$nano

while IFS='=' read -r -d '&' key value; do
   export name=$key
done <<EOF
${Http_Query}&
EOF
cat - > ${OUT}
ffmpeg -loglevel info -nostats -i ${OUT}  -vf fps=15  "${name}_%03d.jpg" < /dev/null
tar cf - *.jpg 
rm ${OUT}
rm *.jpg


