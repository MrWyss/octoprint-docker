FROM ubuntu:16.04
MAINTAINER marius.wyss+dockerhub@gmail.com

RUN apt-get update && apt-get install -y --no-install-recommends \
	python-pip \
	python-dev \
	git \
	build-essential \
	libav-tools \
	avrdude \
	curl


RUN apt-get clean \
	&& rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /octoprint
RUN git clone https://github.com/foosel/OctoPrint.git /octoprint
RUN pip install --upgrade pip
RUN pip install setuptools
RUN pip install -r requirements.txt 
RUN python setup.py install 

VOLUME /data
WORKDIR /data
EXPOSE 5000
CMD ["octoprint",  "--iknowwhatimdoing", "--basedir" ,"/data"]