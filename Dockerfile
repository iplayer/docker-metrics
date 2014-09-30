FROM    phusion/baseimage:0.9.11
ENV     DEBIAN_FRONTEND noninteractive
RUN     apt-get -y update
RUN     apt-get install -y -q python-software-properties software-properties-common

# Install mongo
RUN     apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 &&\
        echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list &&\
        apt-get -y update &&\
        apt-get -y install mongodb-org &&\
        mkdir -p /data/mongodb

# Setup graphite
ADD     ./graphite/initial_data.json /src/graphite/webapp/graphite/initial_data.json
ADD     ./graphite/local_settings.py /src/graphite/webapp/graphite/local_settings.py
ADD     ./graphite/carbon.conf /src/graphite/conf/carbon.conf
ADD     ./graphite/storage-schemas.conf /src/graphite/conf/storage-schemas.conf
ADD     ./graphite/storage-aggregation.conf /src/graphite/conf/storage-aggregation.conf
RUN     mkdir -p /src/graphite/storage/whisper &&\
        touch /src/graphite/storage/graphite.db /src/graphite/storage/index &&\
        chown -R www-data /src/graphite/storage &&\
        chmod 0775 /src/graphite/storage /src/graphite/storage/whisper &&\
        chmod 0664 /src/graphite/storage/graphite.db &&\
        cd /src/graphite/webapp/graphite && python manage.py syncdb --noinput

ADD     ./grafana/config.js /src/grafana/config.js

# Install Seyren
RUN     cd /src &&\
        wget https://github.com/scobal/seyren/releases/download/1.1.0/seyren-1.1.0.jar

# Setup nginx
ADD     ./nginx /etc/nginx
RUN     chown -R www-data:www-data /etc/nginx

# Setup supervisor
RUN     mkdir /etc/service/supervisord
ADD     ./supervisor/supervisord.sh /etc/service/supervisord/run
ADD     ./supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD     ["/sbin/my_init"]
