#!/bin/bash
sudo service postgresql restart
sudo docker-compose down
sudo docker-compose build --no-cache
sudo docker-compose up
