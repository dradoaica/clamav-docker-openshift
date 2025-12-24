# clamav-docker-openshift

It's an OpenShift ready docker image built on top of [Docker Hub: clamav/clamav](https://hub.docker.com/r/clamav/clamav) docker image.

## Build clamav-docker-openshift

docker build -t dradoaica/clamav-openshift:1.5.1 -f Dockerfile .

## Push clamav-docker-openshift

docker push dradoaica/clamav-openshift:1.5.1

## Run clamav-docker-openshift container

docker run -p 0.0.0.0:3310:3310/tcp --name clamav-openshift -d dradoaica/clamav-openshift:1.5.1

## Remove clamav-docker-openshift container

docker rm -f clamav-openshift

## Remove clamav-docker-openshift image

docker rmi dradoaica/clamav-openshift:1.5.1

## Helm Chart

https://github.com/dradoaica/helm-charts/tree/main/charts/clamav-openshift
