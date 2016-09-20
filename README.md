# docker-ringo
[![](https://images.microbadger.com/badges/version/toirl/ringo.svg)](https://microbadger.com/images/toirl/ringo "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/toirl/ringo.svg)](https://microbadger.com/images/toirl/ringo "Get your own image badge on microbadger.com")


Development environment for ringo in a docker image. The docker image already
includes the bare dependecies for ringo development.

The main idea of this image is to mount your ringo based application into the
containers filesystem and run the application within the container.

Please note, that **this images does provide no database**. It is up to you to
setup the required database and connection. See example below.

## How to use
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

