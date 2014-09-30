FROM ubuntu

# Install grafana
RUN     cd /tmp &&\
        wget http://grafanarel.s3.amazonaws.com/grafana-1.8.0.tar.gz &&\
        tar -xzvf grafana-1.8.0.tar.gz && rm grafana-1.8.0.tar.gz &&\
        mv /tmp/grafana-1.8.0/ /src/grafana

ADD     config/config.js /src/grafana/config.js

VOLUME ["/src/grafana"]
