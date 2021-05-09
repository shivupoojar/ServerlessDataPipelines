from minio import Minio
#from minio.error import ResponseError
import json
from random import randrange
import os

def handle(req):
    res = json.loads(req)
    minioClient = Minio('172.17.67.176:9000', access_key='AKIAIOSFODNN7EXAMPLE',
                  secret_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',secure=False)
    json_file = json.dumps(res)
    f = open("/tmp/dict.json","w")
    f.write(json_file)
    f.close()  
   
    if res["result"]=="Success":
#      try:
       minioClient.fput_object('psuccess',str(randrange(100))+'.json','/tmp/dict.json')
#      except ResponseError as err:
#      	    print(err)
    else:
 #     try:
       minioClient.fput_object('pnotsuccess',str(randrange(100))+'.json','/tmp/dict.json')
  #    except ResponseError as err:
 #           print(err)
    return "Completed"
