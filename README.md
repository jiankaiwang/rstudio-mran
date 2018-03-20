# Rstudio-MRAN-Docker

Build a docker image to run a rstudio server docker and the core of rstudio is based on MRAN(https://mran.microsoft.com/).

![demo](https://raw.githubusercontent.com/jiankaiwang/rstudio-mran/master/images/demo.png)

## Rreparation

* Install the Docker(https://docs.docker.com/install/).
* Install the git(https://git-scm.com/downloads).

## Develop

### Build a Docker Image

```bash
$ git clone https://github.com/jiankaiwang/rstudio-mran.git
$ cd ./rstudio-mran
$ sudo docker build -t rstudio-mran .
```

### Run a Container

```bash
# list available docker images
$ sudo docker images

# list running containers
$ sudo docker ps -a

# run the container
$ sudo docker run -d -p 8787:8787 --name rstdmran rstudio-mran

# stop the container
$ sudo docker stop rstdmran

# restart the container
$ sudo docker restart rstdmran

# remove the container
sudo docker rm rstdmran
```

### Interact with Container

```bash
$ sudo docker exec -it rstdmran /bin/bash
```

## Service

* Pull from the dockerhub.

```bash
# pull from the docker
$ sudo docker pull jiankaiwang/rstudio-mran:latest
```

* Browser the server localhost:8787 and Login as the guest:guest.

```bash
# start the container
$ sudo docker run -d -p 8787:8787 --name rstdmran jiankaiwang/rstudio-mran
```

