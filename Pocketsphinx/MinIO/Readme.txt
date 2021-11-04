Pocketsphinx
notify_webhook:11 endpoint=http://192.168.1.223:8080/function/pocketsphinx-eventlistener auth_token= queue_limit=0 queue_dir= client_cert= client_key=
notify_webhook:13 endpoint=http://192.168.1.223:8080/function/pocketsphinx-eventlsitener2 auth_token= queue_limit=0 queue_dir= client_cert= client_key=
notify_webhook:12 endpoint=http://192.168.1.223:8080/function/pocketsphinx-eventlistener2 auth_token= queue_limit=0 queue_dir= client_cert= client_key=
notify_webhook:14 endpoint=http://192.168.1.223:8080/function/pocketsphinx-eventlsitener auth_token= queue_limit=0 queue_dir= client_cert= client_key=
notify_webhook:15 endpoint=http://192.168.1.223:8080/function/pocketsphinx-eventlistener3 auth_token= queue_limit=0 queue_dir= client_cert= client_key=
Pocketsphinx
Client-->rawpocketsphinx-->pocketsphinx-eventlistener-->pocketsphinx-minio-->pocketsphinx-->pocketsphinx-eventlsitener2 -->pocketsphinx-textsearch-http-->processedpocketsphinx-->pocketsphinx-eventlistener3 → pocketsphinx-tocloud-http