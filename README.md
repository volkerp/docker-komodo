
Komdodo Wallet daemon in docker container.


## Building the image
1. git pull https://github.com/volkerp/docker-komodo
2. cd docker-komodo
3. Have a look at komodo.conf and change if necessary
4. Run `docker build -t volkerp/komodo .`

## Creating a container
Run the image in a container,  detached (-d) as a service, with name (--name) 'komodo',
expose peer-to-peer port 7770 and cli port 7771 on localhost, bind mount local path '/path/to/komodo/' on '/root/.komodo'

    docker run -d --name komodo -p 7770:7770 -p 127.0.0.1:7771:7771 -v /path/to/komodo:/root/.komodo volkerp/komodo

## Executing commands 

Run a shell in the container

    docker exec -i -t komodo /bin/bash

`./src/komodo-cli help`
`./src/komodo-cli getinfo`
`...`


