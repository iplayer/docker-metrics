FROM    phusion/baseimage:0.9.11
ENV     DEBIAN_FRONTEND noninteractive
RUN     apt-get -y update
RUN     apt-get install -y -q python-software-properties software-properties-common

# Install dependencies
RUN     apt-get -y install  python-django-tagging python-simplejson python-memcache \
                            python-ldap python-cairo python-django python-twisted   \
                            python-pysqlite2 python-support python-pip gunicorn     \
                            supervisor nginx-light git wget curl

# Install graphite
RUN     pip install https://github.com/graphite-project/ceres/tarball/master &&\
        pip install git+git://github.com/graphite-project/whisper@0.9.x &&\
        pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/lib" git+git://github.com/graphite-project/carbon@0.9.x &&\
        pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/webapp" git+git://github.com/graphite-project/graphite-web@0.9.x

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

# Install Elasticsearch
RUN     apt-get -y install libfuse2 &&\
        cd /tmp ; apt-get download fuse &&\
        cd /tmp ; dpkg-deb -x fuse_* . &&\
        cd /tmp ; dpkg-deb -e fuse_* &&\
        cd /tmp ; rm fuse_*.deb &&\
        cd /tmp ; echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst &&\
        cd /tmp ; dpkg-deb -b . /fuse.deb &&\
        cd /tmp ; dpkg -i /fuse.deb
RUN     apt-get -y install openjdk-7-jre
RUN     cd ~ && wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.1.deb
RUN     cd ~ && dpkg -i elasticsearch-1.2.1.deb && rm elasticsearch-1.2.1.deb
ADD	    ./elasticsearch/run /usr/local/bin/run_elasticsearch
RUN     mkdir /tmp/elasticsearch && chmod 777 /tmp/elasticsearch

# Install grafana
RUN     cd /src &&\
        wget http://grafanarel.s3.amazonaws.com/grafana-1.6.1.tar.gz &&\
        tar -xzvf grafana-1.6.1.tar.gz && rm grafana-1.6.1.tar.gz &&\
        mv grafana-1.6.1 grafana

ADD     ./grafana/config.js /src/grafana/config.js

# Setup nginx
ADD     ./nginx /etc/nginx
RUN     chown -R www-data:www-data /etc/nginx

# Setup supervisor
RUN     mkdir /etc/service/supervisord
ADD     ./supervisor/supervisord.sh /etc/service/supervisord/run
ADD     ./supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD     ["/sbin/my_init"]
