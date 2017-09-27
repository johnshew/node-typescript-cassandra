# node-typescript-cassandra
node in typescript working with local cassandra

## Running cassandra in docker locally

    docker run -d --name ca -p 127.0.0.1:9042:9042 cassandra:latest
    docker exec -it ca bash

## Load Cassandra

Run the scripts in cassandra-tables.cql

## Run the node app

    npm run build
    npm start

