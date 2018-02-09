#!/bin/bash
docker stop $@
docker rm $@
docker-compose up --build -d $@
