from minio import Minio
import json
import base64
import os
import cgi
import io
def handle(event, context):
    bin_data = event.body
    bin_length = len(bin_data)

    # Convert it into a binary stream
    bin_stream = io.BytesIO(bin_data)

    # Fetch the content-type together with multipart boundary separator value from the Header
    # OpenFaaS passes HTTP header values through the environment
    input_content_type = event.headers.get('Content-Type')

    # Parse the multi party form data using cgi FieldStorage library
    form = cgi.FieldStorage(fp=bin_stream, environ={'REQUEST_METHOD': 'POST', 'CONTENT_LENGTH': bin_length,
                                                    'CONTENT_TYPE': input_content_type})
    filename  = form["filename"].value
    file = form["file"].file.read()
    
    res = json.loads(file.decode("utf-8"))
    
    minioClient = Minio('172.17.67.176:9000', access_key='AKIAIOSFODNN7EXAMPLE',
                  secret_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',secure=False)
    json_file = json.dumps(res)
    f = open("/tmp/dict.json","w")
    f.write(json_file)
    f.close()  
   
    if res["result"]=="Success":
#      try:
       minioClient.fput_object('psuccess',filename+'.json','/tmp/dict.json')
#      except ResponseError as err:
#           print(err)
    else:
 #     try:
       minioClient.fput_object('pnotsuccess',filename,'/tmp/dict.json')
  #    except ResponseError as err:
 #           print(err)

    return {
        "statusCode": 200,
        "body": "Success"
    }


