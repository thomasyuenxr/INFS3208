FROM ubuntu:18.04

LABEL maintainer="Xiwei Ruan xiwei.ruan@uqconnect.edu.au"

ARG PHPVER=7.4
ARG TIMEZONE=Australia/Brisbane

RUN apt-get update \
    && ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
    && apt-get install software-properties-common -y \
    && yes '' | add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install nginx php${PHPVER}-fpm -y

COPY /src/index* /var/www/html/
COPY /src/nginx.ini /etc/nginx/sites-available/default

WORKDIR /var/www/html

VOLUME [ "cca1/src" ]

EXPOSE 80

ENTRYPOINT [ "/bin/sh" , "-c" , "service php7.4-fpm start && nginx -g 'daemon off;'" ]