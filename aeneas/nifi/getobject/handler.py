import os
import json
from datetime import datetime
from minio import Minio
#from aeneas.tools.execute_task import ExecuteTaskCLI



def handle(req):
     dt = datetime.today()
     file = dt.minute
 #   write_to_file("/tmp/file.mp3",event["body"])
     mc = Minio("172.17.67.176:9000",
                 access_key="AKIAIOSFODNN7EXAMPLE",
                  secret_key='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY',
                  secure=False)
     mc.fget_object("aeneas", req, "/tmp/"+str(file)+".xhtml")
     with open("/tmp/"+str(file)+".xhtml") as f:
    	 contents = f.read()
     return contents
