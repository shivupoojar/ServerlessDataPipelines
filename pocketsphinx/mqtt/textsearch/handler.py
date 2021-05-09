import paho.mqtt.client as mqtt
import json
def handle(req):
    data = { "result":"Not found","text":req}
    words = req.split()
    for word in words:
      if word=="son":
        data = {"result":"Success","text":req} 
    broker_address="172.17.67.176" 
#broker_address="iot.eclipse.org" #use external broker
    client = mqtt.Client("P1") #create new instance
    client.connect(broker_address) #connect to broker
    client.publish("tocloud",json.dumps(data))
    #publish

    return json.dumps(data)

