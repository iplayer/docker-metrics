FROM    nginx

RUN     apt-get -y update
RUN     apt-get -y install wget
RUN     mkdir /src
RUN     mkdir -p /data/log/nginx

# Install grafana
RUN     cd /tmp &&\
        wget http://grafanarel.s3.amazonaws.com/grafana-1.8.0.tar.gz &&\
        tar -xzvf grafana-1.8.0.tar.gz && rm grafana-1.8.0.tar.gz &&\
        mv /tmp/grafana-1.8.0/ /src/grafana

ADD     config/config.js /src/grafana/config.js

COPY    config/nginx/nginx.conf /etc/nginx/nginx.conf
COPY    config/nginx/grafana.conf /etc/nginx/sites-enabled/grafana.conf
COPY    config/nginx/graphite.conf /etc/nginx/sites-enabled/graphite.conf
COPY    config/nginx/elasticsearch.conf /etc/nginx/sites-enabled/elasticsearch.conf
COPY    config/nginx/seyren.conf /etc/nginx/sites-enabled/seyren.conf

VOLUME  ["/data"]
VOLUME  ["/certificates"]

EXPOSE  443
