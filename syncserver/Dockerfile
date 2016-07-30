FROM debian:stable

MAINTAINER Jonathan Dray <jonathan.dray@gmail.com>, BirgerK <birger.kamp@gmail.com>

# Configure APT
ENV DEBIAN_FRONTEND noninteractive
ENV SERVER_HOME /usr/local/share/syncserver
ENV CONFIG_HOME /usr/local/share/config
RUN echo 'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";' | tee -a /etc/apt/apt.conf

# install dockerize
RUN curl -L -O https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    rm -rf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Base setup
# ADD resources/etc/apt/ /etc/apt/
RUN apt-get -y update && \
    apt-get install -q -y python-dev git-core python-virtualenv g++ && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Locales configuration
RUN locale-gen C.UTF-8 && LANG=C.UTF-8 /usr/sbin/update-locale
ENV LANG C.UTF-8

# Get the latest version at https://github.com/mozilla-services/syncserver and run the build command
RUN cd /usr/local/share && git clone https://github.com/mozilla-services/syncserver
WORKDIR $SERVER_HOME
RUN make build

# Add the configuration file
RUN mkdir $CONFIG_HOME
ADD resources/syncserver.ini $CONFIG_HOME/syncserver.ini.j2
ADD resources/entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh

# Run the Sync server
EXPOSE 5000
VOLUME ["/data", $CONFIG_HOME]
ENTRYPOINT ["/entrypoint.sh"]
