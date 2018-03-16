#name of container: rstudio-mran
#versison of container: 0.0.1
FROM quantumobject/docker-baseimage:16.04
MAINTAINER JianKai Wang "https://jiankaiwang.no-ip.biz"

# Update the container
# Installation of nesesary package/software for this containers...
RUN (echo "deb http://cran.mtu.edu/bin/linux/ubuntu `cat /etc/container_environment/DISTRIB_CODENAME`/" >> /etc/apt/sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9)
RUN apt-get update && apt-get install -y -q gdebi-core \
                                              libapparmor1  \
                                              sudo \
                                              libcurl4-openssl-dev \
                                              libssl1.0.0 \
                  && apt-get clean \
                  && rm -rf /tmp/* /var/tmp/* \
                  && rm -rf /var/lib/apt/lists/*

RUN wget https://mran.blob.core.windows.net/install/mro/3.4.3/microsoft-r-open-3.4.3.tar.gz \
					&& tar -xf microsoft-r-open-3.4.3.tar.gz \
					&& microsoft-r-open/install.sh \
					&& rm microsoft-r-open-3.4.3.tar.gz             
RUN wget https://download2.rstudio.org/rstudio-server-1.1.442-amd64.deb \
                                              && gdebi -n rstudio-server-1.1.442-amd64.deb \
                                              && rm /rstudio-server-1.1.442-amd64.deb
    
##startup scripts
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding Deamons to containers
RUN mkdir /etc/service/rserver /var/log/rserver ; sync
COPY rserver.sh /etc/service/rserver/run
RUN chmod +x /etc/service/rserver/run \
    && cp /var/log/cron/config /var/log/rserver/ \
    && chown -R rstudio-server /var/log/rserver

#add files and script that need to be use for this container
#include conf file relate to service/daemon
#additionsl tools to be use internally
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)

# to allow access from outside of the container to the container service
# at that ports need to allow access from firewall if need to access it outside of the server.
EXPOSE 8787

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
