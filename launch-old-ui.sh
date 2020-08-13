#!/usr/bin/env bash
echo "Para Esto es necesario usar la version de node 10.9.0"
echo "Tu version de node js es: $(node --version)"
sleep 2;

echo
docker ps

cd repos/old-ui/UI
ls node_modules &> /dev/null || npm install
gulp &> /dev/null || npm install -g gulp
gulp serve