#!bin/bash

docker build -t app .
docker run -d -p 80:80 app