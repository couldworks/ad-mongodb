FROM couldworks/alpine-base:3.4
MAINTAINER CouldWorks <adribeiro@gmail.com>

RUN apk add --update util-linux pwgen

RUN echo "@testing http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --update mongodb@testing pwgen  \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

VOLUME /data/db

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD run.sh /run.sh
ADD config.sh /config.sh
ADD config.js /config.js

RUN chmod +x /config.sh
RUN chmod +x /run.sh

EXPOSE 27017 28017

CMD ["/run.sh"]
