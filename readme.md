# docker deploy test

Small project to test how to deploy a docker project to digitalocean or similar. The goal is to deploy and run a docker project with docker-compose file, and to be able to update it.

## workflow

I'd expected to create a remote machine with `docker-machine` on DO or similar. Then just deploy my built image there directly with docker-compose commands (after eval of docker-machine). This didn't work. Tried many different things, issue seems to be I'm on linux. Should be able to do things natively and not with docker-machine/docker-compose, but all examples show those options only. Instead I am using docker-machine to ssh into the remote machine, and then git pull the project and run docker build and docker run there.



- create a remote machine with `docker-machine`
- ssh into it with `docker-machine ssh [app]`
- normal git workflow
- ssh into remote machine, git pull, `docker build` & `docker run`
    - `docker build -t test-app .`
    - `docker run -d -p 3004:80 test-app`

## initial deploy
- get a digital ocean API key, set it as an env locally with `export DO_TOKEN="INSERT_TOKEN_HERE"`
- run this command to create a remote VPS (replace 'test-app' with your app name: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=1gb test-app`
- `docker-machine ssh test-app`
- `git clone [repo] test-app`
- [follow update workflow]


## update workflow

- `docker-machine ssh test-app`
- `cd test-app`
- `bash update-app.sh`

### to do

- multi container deploy
- use docker-compose file


## The below didn't work:

- get a digital ocean API key, set it as an env locally with `export DO_TOKEN="INSERT_TOKEN_HERE"`
- run this command to create a remote VPS (replace 'test-app' with your app name: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=1gb test-app`
- run `export COMPOSE_TLS_VERSION=TLSv1_2` to avoid a tls error in next step
- run `export DOCKER_TLS_VERIFY=1`
- set as active machine with command (again replacing 'test-app'): `eval $(docker-machine env test-app)`
- `sudo docker-compose build web`
    - this gave me ssl errors & more, until I prepended it with sudo
- get the IP address of the running instance `docker-machine ip test-app`
- start container: `sudo docker-compose up web`

The above didn't work, it just deployed locally and not to remote machine.

finally made some progress based via this article: https://medium.com/@manuel.pineault/deploying-reactjs-with-docker-ac16728c0896
- creating and publishing image to dockerhub, then creating server from docker-machine, ssh'ng in, and pulling image from dockerhub

for linux, extra scripts are needed to make entering the docker machine/container (remote) obvious from the shell/console. This article is useful: http://linuxbsdos.com/2016/12/14/how-to-install-docker-machine-on-linux-mint-18-and-18-1/

also useful, SO post: https://stackoverflow.com/questions/47273235/eval-docker-machine-env-myvm1-does-not-switch-to-shell-to-talk-to-myvm1

and this article: https://docs.docker.com/install/linux/linux-postinstall/

`docker build`: https://docs.docker.com/engine/reference/commandline/build/#options
`docker run`: https://docs.docker.com/engine/reference/run/#container-identification