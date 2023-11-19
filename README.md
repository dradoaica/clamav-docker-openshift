# clamav-docker-openshift

## build clamav-docker-openshift
docker build -t dradoaica/clamav-openshift:1.2.1 -f Dockerfile .

## run container
docker run -p 0.0.0.0:3310:3310/tcp --name clamav-openshift -d dradoaica/clamav-openshift:1.2.1

## remove container
docker rm -f clamav-openshift

## remove image
docker rmi dradoaica/clamav-openshift:1.2.1