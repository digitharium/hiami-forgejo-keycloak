#! /bin/bash

# This script needs to be manually run once keycloak docker is working

# in order to copy this file to the container:
docker cp ./keycloak/cli_init/ $(docker container ls --all --quiet --filter "name=^keycloak$"):/opt/keycloak/
# make executable
docker exec --privileged -i keycloak chmod 755 -R /opt/keycloak/cli_init
# connect to the docker container and then run /opt/keycloak/cli_init/init.sh
docker exec --privileged -i keycloak sh /opt/keycloak/cli_init/init.sh