#use latest armv7hf compatible raspbian OS version from group resin.io as base image
FROM resin/armv7hf-debian:jessie

#enable building ARM container on x86 machinery on the web (comment out next line if built on Raspberry)
RUN [ "cross-build-start" ]

#labeling
LABEL maintainer="netpi@hilscher.com" \
      version="V0.9.1.0" \
      description="Raspbian(Debian:jessie) with soft PLC straton from COPA-DATA"

#version
ENV HILSCHERNETPI_STRATON_SOFTPLC 0.9.1.0

#copy files
COPY "./init.d/*" /etc/init.d/

#do installation
RUN apt-get update  \
    && apt-get install -y wget unzip \
#create user pi
    && useradd --create-home --shell /bin/bash pi \
    && echo 'pi:raspberry' | chpasswd \
    && adduser pi sudo \
#download straton for raspberry runtime
    && wget -P /tmp/ --no-check-certificate https://www.straton-plc.com/fileadmin/user_upload/Download/straton.9.1.T5LINUX-RaspberryPI.zip \
    && unzip /tmp/straton.9.1.T5LINUX-RaspberryPI.zip -d /tmp/ \
#make runtime executeable
    && chmod +x /tmp/T5LINUX-RaspberryPI/Runtime/t5pi91 \
#move piface2 library
    && cp /tmp/T5LINUX-RaspberryPI/Runtime/libpiface-1.0.so /usr/local/lib \
    && ldconfig \
#move straton runtime 
    && cp /tmp/T5LINUX-RaspberryPI/Runtime/t5pi91 /home/pi/ \
#clean up
    && rm -rf /tmp/* \
    && apt-get remove wget unzip \
    && apt-get -yqq autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

#straton port
EXPOSE 1100

#do startscript
ENTRYPOINT ["/etc/init.d/entrypoint.sh"]

#set STOPSGINAL
STOPSIGNAL SIGTERM

#stop processing ARM emulation (comment out next line if built on Raspberry)
RUN [ "cross-build-end" ]
