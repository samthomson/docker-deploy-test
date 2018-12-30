# docker deploy test

Small project to test how to deploy a docker project to digitalocean or similar. The goal is to deploy and run a docker project with docker-compose file, and to be able to update it.

## workflow

- get a digital ocean API key, set it as an env locally with `export DO_TOKEN="INSERT_TOKEN_HERE"`
- run this command to create a remote VPS (replace 'test-app' with your app name: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=1gb test-machine` (replacing `test-machine` with a name for the instance)
- set as active machine with command (again replacing 'test-machine'): `eval $(docker-machine env test-machine)`
- build container/service `docker-compose build web`
- get the IP address of the running instance `docker-machine ip test-machine`
- start container: `docker-compose up web`
- work on the project as normal, and when you want to redeploy just run `docker-compose up --build web`

## alternative workflow

I'd expected to create a remote machine with `docker-machine` on DO or similar. Then just deploy my built image there directly with docker-compose commands (after eval of docker-machine). This didn't work. Tried many different things, issue seems to be I'm on linux. Should be able to do things natively and not with docker-machine/docker-compose, but all examples show those options only. Instead I am using docker-machine to ssh into the remote machine, and then git pull the project and run docker build and docker run there.


- create a remote machine with `docker-machine`
- ssh into it with `docker-machine ssh [app]`
- normal git workflow
- ssh into remote machine, git pull, `docker build` & `docker run`
    - `docker build -t test-app .`
    - `docker run -d -p 3004:80 test-app`

### initial deploy
- get a digital ocean API key, set it as an env locally with `export DO_TOKEN="INSERT_TOKEN_HERE"`
- run this command to create a remote VPS (replace 'test-app' with your app name: `docker-machine create --driver=digitalocean --digitalocean-access-token=$DO_TOKEN --digitalocean-size=1gb test-app`
- `docker-machine ssh test-app`
- `git clone [repo] test-app`
- [follow update workflow]


### update workflow

- `docker-machine ssh test-app`
- `cd test-app`
- `bash update-app.sh`


## notes

- I had a lot of problems with this, all of which were resolved by updating docker-compose to the latest version.
- for linux, extra scripts are needed to make entering the docker machine/container (remote) obvious from the shell/console. This article is useful: http://linuxbsdos.com/2016/12/14/how-to-install-docker-machine-on-linux-mint-18-and-18-1/

### for alternative work flow

- also useful, SO post: https://stackoverflow.com/questions/47273235/eval-docker-machine-env-myvm1-does-not-switch-to-shell-to-talk-to-myvm1
- and this article: https://docs.docker.com/install/linux/linux-postinstall/
- `docker build`: https://docs.docker.com/engine/reference/commandline/build/#options
- `docker run`: https://docs.docker.com/engine/reference/run/#container-identification
- also possible, deploy and pull via dockerhub: https://medium.com/@manuel.pineault/deploying-reactjs-with-docker-ac16728c0896
    - creating and publishing image to dockerhub, then creating server from docker-machine, ssh'ng in, and pulling image from dockerhub



## to do

- multi container deploy
- use docker-compose file