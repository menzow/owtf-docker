FROM kalilinux/kali-linux-docker

MAINTAINER @viyatb viyat.bhalodia@owasp.org, @alexandrasandulescu alecsandra.sandulescu@gmail.com

ENV PYCURL_SSL_LIBRARY openssl
ENV TERM xterm
ENV SHELL /bin/bash


EXPOSE 8010 8009 8008


RUN apt-get update --fix-missing && apt-get upgrade -y && \
    apt-get install -y  sudo \
        git \
        python-setuptools \
        python-pip \
        xvfb \
        xserver-xephyr \
        libxml2-dev \
        libxslt-dev \
        postgresql-server-dev-all \
        libcurl4-openssl-dev \
        proxychains \
        unzip \
        build-essential \
        libssl-dev \
        libz-dev \
        libffi-dev \
        python-dev \
        postgresql \
        postgresql-client \
        theharvester \
        tlssled \
        nikto \
        dnsrecon \
        nmap \
        whatweb \
        skipfish \
        dirbuster \
        metasploit-framework \
        wpscan \
        wapiti \
        waffit \
        hydra \
        metagoofil \
        o-saft \
        postgresql-client-common && \
    apt-get clean && \
    apt-get autoremove -y

RUN git clone https://github.com/owtf/owtf.git /owtf && \
    mkdir -p /owtf/tools/restricted && \
    python /owtf/install/install.py

COPY postgres_entry.sh /owtf/scripts

COPY owtf_entry.sh /usr/bin/
RUN chmod +x /usr/bin/owtf_entry.sh

USER postgres
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

ENV USER root
USER root

WORKDIR /data

ENTRYPOINT ["/usr/bin/owtf_entry.sh"]

