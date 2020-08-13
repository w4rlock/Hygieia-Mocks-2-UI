#!/usr/bin/env bash
if ! docker ps &> /dev/null; then
  echo "Error: verify that docker is running"
  echo "after that, run next command to check all is right:"
  echo "docker run hello-world"
  exit 1
fi

./stop.sh &> /dev/null
mkdir logs &> /dev/null
mkdir repos &> /dev/null

echo "Cloning mocks repo..."
git clone https://github.com/liatrio/Hygieia-data.git repos/mocks &> /dev/null
(
  cd repos/mocks
  echo "Installing npm dependencies for mocks.."
  npm install &> ../../logs/npm-install-mocks.log
)


echo "Cloning new Hygieia UI..."
git clone https://github.com/Hygieia/UI.git repos/new-ui &> /dev/null
(
  cd repos/new-ui
  echo "Installing npm dependencies for new ui..."
  npm install &> ../../logs/npm-install-new-ui.log
)


echo "Cloning old Hygieia UI..."
git clone https://github.com/Hygieia/Hygieia.git repos/old-ui &> /dev/null
(
  cd repos/old-ui/UI/
  echo "Installing npm dependencies for old ui..."
  npm install &> ../../../logs/npm-install-old-ui.log
  echo "Installing gulp..."
  npm i -g gulp  &> /dev/null
)


echo "Starting mongodb..."
docker-compose up -d mongodb
sleep 10


echo "Creating mongo user..."
docker exec db mongo localhost/admin  --eval 'db.getSiblingDB("dashboard").createUser({user: "db", pwd: "dbpass", roles: [{role: "readWrite", db: "dashboard"}]})' > logs/mongo-script.log

