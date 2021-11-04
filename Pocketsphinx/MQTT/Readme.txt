Client(pocketsphinx)-->MQTT-->pocketsphinx-mqtt(tocloud)(getobject)-->MQTT-->textsearch-->MQTT-->tocloud(cloud)

echo GATEWAY_PASS=7900c7ed655e734de98f62aa5e2b484cfc2b6052547e7a270d45c6d7ccb50173
./mqtt-connector --gateway http://192.168.1.223:8080 --gw-username admin --gw-password $GATEWAY_PASS   --broker 192.168.1.249:1883 --topic pocketsphinx --async-invoke  true