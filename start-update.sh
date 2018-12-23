#!bin/bash

# ssh into remote machine, then run command to run update script on server
docker-machine ssh test-app "cd test && bash update-app.sh"