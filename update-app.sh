#!bin/bash

# remove last instance
docker rm $(docker stop $(sudo docker ps -aqf "name=test-name"))
# build new instance
docker build -t app .
# run the new instance
docker run -d -p 80:80 --name=test-name app


# docker rm $(docker stop $(docker ps -a -q --filter ancestor=<app> --format="{{.ID}}"))

# docker rm $(docker stop $(sudo docker ps -aqf "name=test-name"))

# sudo docker ps -aqf "name=test-app"