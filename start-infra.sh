#!/usr/bin/env bash
echo "Starting docker infra...."
docker-compose up -d
sleep 4;


echo
docker ps
