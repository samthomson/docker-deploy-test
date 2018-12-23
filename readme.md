# docker deploy test

Small project to test how to deploy a docker project to digitalocean or similar. The goal is to deploy and run a docker project with docker-compose file, and to be able to update it.

## workflow

I'd expected to create a remote machine with `docker-machine` on DO or similar. Then just deploy my built image there directly with docker-compose commands (after eval of docker-machine). This didn't work. Tried many different things, issue seems to be I'm on linux. Should be able to do things natively and not with docker-machine/docker-compose, but all examples show those options only. Instead I am using docker-machine to ssh into the remote machine, and then git pull the project and run docker build and docker run there.



- create a remote machine with `docker-machine`
- ssh into it with `docker-machine ssh [app]`
- normal git workflow
- ssh into remote machine, git pull, `docker run`


### to do

- create script that automates some of this
- multi container deploy
- build and run in one command
- use docker-compose file


## how to run (doesn't work - see above)

- get a digital ocean API key, set it as an env locally with `export DO_TOKEN="INSERT_TOKEN_HERE"`
- run this command to create a remote VPS (replace 'test-app' with your app name: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=1gb test-app`
- run `export COMPOSE_TLS_VERSION=TLSv1_2` to avoid a tls error in next step
- run `export DOCKER_TLS_VERIFY=1`
- set as active machine with command (again replacing 'test-app'): `eval $(docker-machine env test-app)`
- `sudo docker-compose build web`
    - this gave me ssl errors & more, until I prepended it with sudo
- get the IP address of the running instance `docker-machine ip test-app`
- start container: `sudo docker-compose up web`


sudo docker-compose up -d --force-recreate --build web


docker run -d -p 80:80 --name web


can deploy someone elses container, just not mine...


sudo sh -c 'eval "$(docker-machine env test-app)"; docker-machine ls'


docker-compose -p web up -d --build


finally made some progress based on this article: https://medium.com/@manuel.pineault/deploying-reactjs-with-docker-ac16728c0896
- creating and publishing image to dockerhub, then creating server from docker-machine, ssh'ng in, and pulling image from dockerhub

it keeps getting deployed locally.. not to remote machine..



for linux, extra scripts are needed to make entering the docker machine/container (remote) obvious from the shell/console. This article is useful: http://linuxbsdos.com/2016/12/14/how-to-install-docker-machine-on-linux-mint-18-and-18-1/

as is this SO post: https://stackoverflow.com/questions/47273235/eval-docker-machine-env-myvm1-does-not-switch-to-shell-to-talk-to-myvm1

and this article: https://docs.docker.com/install/linux/linux-postinstall/

still can't push directly to the remote instance, but what I can do is ssh in from docker-machine command `docker-machine ssh test-app` and then do a git pull, followed by `docker build` and `docker run` command.
Could potentially automate this with a bash script?