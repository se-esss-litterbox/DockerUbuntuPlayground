FROM ubuntu:14.04
MAINTAINER sdmolloy@gmail.com

RUN apt-get -y update && \
	apt-get -y install build-essential xterm man wget readline-common libreadline-dev sudo unzip vim

RUN mkdir tmp_epics && \
	cd tmp_epics && \
	wget -nv http://www.aps.anl.gov/epics/download/base/baseR3.14.12.5.tar.gz && \
	wget -nv http://aps.anl.gov/epics/download/modules/asyn4-28.tar.gz && \
	wget -nv http://epics.web.psi.ch/software/streamdevice/StreamDevice-2.tgz && \
	cd ..

RUN mkdir epics && \
	cd epics && \
	tar -zxf ../tmp_epics/baseR3.14.12.5.tar.gz -C ./ && \
	ln -s /epics /usr/local && \
	ln -s /epics/base-3.14.12.5 /epics/base && \
	cd base && \
	make

RUN mkdir /epics/modules && \
	tar -zxf /tmp_epics/asyn4-28.tar.gz -C /epics/modules/ && \
	ln -s /epics/modules/asyn4-28 /epics/modules/asyn && \
	cd /epics/modules/asyn && \
	sed -i 's/^IPAC/#IPAC/' configure/RELEASE && \
	sed -i 's/^SNCSEQ/#SNCSEQ/' configure/RELEASE && \
	sed -i 's/^EPICS_BASE.*/EPICS_BASE=\/usr\/local\/epics\/base/' configure/RELEASE && \
	make

RUN mkdir /epics/modules/stream && \
	cd /epics/modules/stream && \
	tar -zxf /tmp_epics/StreamDevice-2.tgz -C /epics/modules/stream && \
	export USER="root" && \
	export EPICS_ROOT=/usr/local/epics && \
	export EPICS_BASE=${EPICS_ROOT}/base && \
	export EPICS_HOST_ARCH=`${EPICS_BASE}/startup/EpicsHostArch` && \
	export EPICS_BASE_BIN=${EPICS_BASE}/bin/${EPICS_HOST_ARCH} && \
	export EPICS_BASE_LIB=${EPICS_BASE}/lib/${EPICS_HOST_ARCH} && \
	export LD_LIBRARY_PATH=${EPICS_BASE_LIB}:${LD_LIBRARY_PATH} && \
	export PATH=${PATH}:${EPICS_BASE_BIN} && \
	makeBaseApp.pl -t support "" && \
	echo "ASYN=/usr/local/epics/modules/asyn" >> configure/RELEASE && \
	make && \
	cd StreamDevice-2-6 && \
	make

COPY ./aliasContents.txt /root/.bash_aliases

USER root
WORKDIR /root

EXPOSE 5064 5065

