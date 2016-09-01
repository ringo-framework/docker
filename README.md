# ringo-docker
Development environment for ringo in a docker image. The docker image already includes the bare dependecies for ringo development.

Please note, that **this images does provide no database**. It is up to you to setup the required database and connection. See example below.

## How to run
Start the container and mount your application into the correct folder in the container::

	docker run -i -t \
		   -v /path/to/your/application:/ringo/src \
		   ringo/dev
