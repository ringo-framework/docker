FROM ubuntu:latest
MAINTAINER Torsten Irländer <torsten.irlaender@googlemail.com>

RUN apt-get update && apt-get install -y \
	curl sudo vim \
	git \
	python-virtualenv python-dev \
	postgresql-client-9.5 postgresql-server-dev-9.5 \
	gcc

RUN curl -O https://raw.githubusercontent.com/ringo-framework/ringo/master/bootstrap-dev-env.sh; \
sh bootstrap-dev-env.sh ringo

WORKDIR /ringo
ENV PATH /ringo/env/bin:$PATH
RUN pcreate -t ringo src
WORKDIR /ringo/src
RUN python setup.py develop
COPY ./update_ringo.sh /ringo
COPY ./entrypoint.sh /ringo
ENTRYPOINT ["/ringo/entrypoint.sh"]
CMD ["Hello Ringo"]
