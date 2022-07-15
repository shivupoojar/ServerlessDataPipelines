from minio import Minio
import requests
import json
import os
import uuid

def handle(req):
    """handle a request to the function
    Args:
        req (str): request body
    """
    payload = json.loads(req)
    print(payload)
    mc = Minio(os.environ['minio_hostname'],
                access_key=get_secret('access-key'),
                secret_key=get_secret('secret-key'),
                secure=False)

    records       = payload['Records'][0]['s3']
    source_bucket = records['bucket']['name']
    file_name     = records['object']['key']
    dest_bucket   = "yololess"

    load(source_bucket, dest_bucket, file_name, mc)

def get_secret(key):
    val = ""
    with open("/var/openfaas/secrets/" + key) as f:
        val = f.read()
    return val

def load(source_bucket, dest_bucket, file_name, mc):
    mc.fget_object(source_bucket, file_name, "/tmp/" + file_name)
    with open("/tmp/"+ file_name,"rb") as f:
    	input_image = f.read()
    print(input_image)
#    input_image = f.read()

    # convert image to black and white
    r = requests.post("http://192.168.1.223:8080/function/sdp2plain2json", data=input_image)
    print(r)

    return file_name


