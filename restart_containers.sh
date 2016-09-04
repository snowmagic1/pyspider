docker rm -f webui scheduler processor fetcher result_worker
docker run --name scheduler -d --link mysql:mysql --link rabbitmq:rabbitmq --network=crawler snowmagic/pyspider:latest scheduler   
docker run --name fetcher -m 256m -d --link phantomjs:phantomjs --link rabbitmq:rabbitmq --network=crawler  snowmagic/pyspider:latest fetcher --no-xmlrpc
docker run --name processor -m 256m -d --link mysql:mysql --link rabbitmq:rabbitmq --network=crawler snowmagic/pyspider:latest processor
docker run --name result_worker -m 128m -d --link mysql:mysql --link rabbitmq:rabbitmq --network=crawler snowmagic/pyspider:latest result_worker 
docker run --name webui -m 256m -d -p 5000:5000 --link mysql:mysql --link rabbitmq:rabbitmq --link scheduler:scheduler \
           --network=crawler snowmagic/pyspider:latest webui --scheduler-rpc http://scheduler:23333/