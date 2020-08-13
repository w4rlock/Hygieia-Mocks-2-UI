#!/usr/bin/env bash
echo
docker ps

cd repos/new-ui
npm run start

echo
echo "Hygieia UI:"
echo "http://localhost:4200/"