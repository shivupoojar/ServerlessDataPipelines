from minio import Minio
from minio.error import ResponseError
import json
import os

def handle(req):
    res = req.split()
    minioClient = Minio('172.17.67.176:9000', access_key='AKIAIOSFODNN7EXAMPLE',
                  secret_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',secure=False)
   # printing result
    dict_file = {
                    "image": res[0].split("/")[2],
                    "Predicted Time": res[3] + res[4],
                     "Detected objects": res[5:]
                  }
    json_file = json.dumps(dict_file)
    f = open("/tmp/dict.json","w")
    f.write(json_file)
    f.close()  
    try:
       minioClient.fput_object('sdp2output',res[0].split("/")[2].split(".")[0]+'.json','/tmp/dict.json')
    except ResponseError as err:
       print(err)
    
    return json_file



