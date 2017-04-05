FROM python:3.4-wheezy
MAINTAINER nsoushi

ENV SUPERSET_VERSION 0.17.3
ENV SUPERSET_HOME /superset
ENV SUPERSET_DB_URI "mysql://root@mysql:3306/app"

ENV PYTHONPATH $SUPERSET_HOME:$PYTHONPATH

ENV ADMIN_USERNAME admin
ENV ADMIN_FIRST_NAME admin
ENV ADMIN_LAST_NAME user
ENV ADMIN_EMAIL admin
ENV ADMIN_PWD superset

ENV DB_PACKAGES libmysql++-dev
ENV DB_PIP_PACKAGES mysqlclient

RUN apt-get update && \
    apt-get install -y build-essential \
    libssl-dev libffi-dev libsasl2-dev libldap2-dev
RUN pip install --no-cache-dir \
    $DB_PIP_PACKAGES flask-appbuilder superset==$SUPERSET_VERSION
RUN apt-get remove -y \
    build-essential libssl-dev libffi-dev libsasl2-dev libldap2-dev
RUN apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install --user flask-oauthlib

RUN apt-get update && apt-get install -y $DB_PACKAGES && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir $SUPERSET_HOME

COPY superset-init.sh /superset-init.sh
RUN chmod +x /superset-init.sh

VOLUME $SUPERSET_HOME
EXPOSE 8088

ENTRYPOINT [ "/superset-init.sh" ]
