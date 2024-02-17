# clamav-docker-openshift

## build clamav-docker-openshift
docker build -t dradoaica/clamav-openshift:1.3 -f Dockerfile .

## push clamav-docker-openshift
docker push dradoaica/clamav-openshift:1.3

## run container
docker run -p 0.0.0.0:3310:3310/tcp --name clamav-openshift -d dradoaica/clamav-openshift:1.3

## remove container
docker rm -f clamav-openshift

## remove image
docker rmi dradoaica/clamav-openshift:1.3