FROM ubuntu:14.04
MAINTAINER sdmolloy@gmail.com

RUN apt-get -y update && \
	apt-get -y install build-essential xterm man wget readline-common libreadline-dev sudo unzip vim

RUN adduser --disabled-password --gecos "" pi && \
	echo "pi:pi" | chpasswd && \
	adduser pi sudo

RUN wget https://github.com/se-esss-litterbox/EPICSpi/archive/master.zip && \
	unzip master.zip

RUN export USER="pi" && \
	cd EPICSpi-master && \
	./installEPICS.sh

EXPOSE 5064
EXPOSE 5065

