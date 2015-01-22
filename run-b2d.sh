#!/bin/sh

# Set up data container for workspace (if it doesn't exist already)
docker run --name dsh-ws -v /workspace busybox true 2>/dev/null

# Start samba file sharing (if it hasn't started already)
# if [ $(docker inspect --format "{{.State.Running}}" samba-server 2>/dev/null) == false ]; then
    # Set up file sharing container
    docker run --name dsh-share --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba dsh-ws
# fi

# Now run the docker shell container
docker run -e DOCKER_HOST=tcp://boot2docker:2376 \
    -e DOCKER_CERT_PATH=/etc/docker-certs \
	-e DOCKER_TLS_VERIFY=1 \
	-v /var/lib/boot2docker/tls:/etc/docker-certs \
    --net=host -t -i \
    --volumes-from dsh-ws developer
