#!/bin/bash

# docker container prune
# docker rmi alquilarbot_web -f
docker-compose build
docker-compose stop
docker-compose rm -f
docker-compose up -d
