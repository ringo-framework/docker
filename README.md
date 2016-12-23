# docker-ringo
[![](https://images.microbadger.com/badges/version/toirl/ringo.svg)](https://microbadger.com/images/toirl/ringo "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/toirl/ringo.svg)](https://microbadger.com/images/toirl/ringo "Get your own image badge on microbadger.com")


Development environment for Ringo in a docker image. The docker image already
includes the bare dependecies for Ringo development including almost all Ringo extensions.

The main idea of this image is to mount your Ringo based application into the
containers filesystem and run the application within the container.

Please note, that **this images does provide no database**. It is up to you to
setup the required database and connection. See example below.

## For the lazy ones
This repository comes with a shell script named `docker-ringo.sh`.
This script can be used to init, update and run a Ringo based application in a ringo
container. 

There is only one requirement: Make sure you
have a docker.ini config file in it. Make sure you have configured the SQLAlchemy connection string correct.
A example docker.ini file is also included in this repository.

You can run your application with the following command:ository:

	cd /path/to/my/app

Init the database:

	docker-ringo init $APPNAME

Run the application:

	docker-ringo start $APPNAME

## All commands in detail
First of all we need a running database. In this example we will use a
PostgreSQL database:

	docker run --name ringo-postgres \
		-e POSTGRES_USER=ringo \
		-e POSTGRES_PASSWORD=ringo \
		-d postgres

### Update the development environment
To update the development environment and to get the latest sources of Ringo,
Formbar and Brabbel run the following command:

	docker run --name youridentifier \
		-t \
		-i \
		--link ringo-postgres
		-v /path/to/your/application:/ringo/src \
		toirl/ringo update

### (Re)init the database
To (Re)initialize the database for your application invoke the following
command:

	docker run --name youridentifier \
		-t \
		-i \
		--link ringo-postgres
		-v /path/to/your/application:/ringo/src \
		toirl/ringo init <appname> [configfile]

### Run the application
To start the application run:

	docker run --name youridentifier \
		-t \
		-i \
		--link ringo-postgres
		-v /path/to/your/application:/ringo/src \
		-p 6543:6543 \
		toirl/ringo run [configfile]


