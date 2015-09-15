FROM ubuntu
MAINTAINER marius.wyss+dockerhub@gmail.com
#OctoPrint
#docker run -d -p 5000:5000 --device=/dev/ttyUSB0 --name=octoprint-docker-testrun mrwyss/octoprint-docker

RUN apt-get update && apt-get install -y --no-install-recommends \
	python-pip \
	python-dev \
	git \
	build-essential \
	libav-tools


RUN apt-get clean \
	&& rm -rf /tmp/* /var/tmp/*  \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /octoprint
RUN git clone https://github.com/foosel/OctoPrint.git /octoprint
RUN pip install -r requirements.txt 
RUN python setup.py install 

VOLUME /data
WORKDIR /data
EXPOSE 5000
CMD ["octoprint",  "--iknowwhatimdoing", "--basedir" ,"/data"]
