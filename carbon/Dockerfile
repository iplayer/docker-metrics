FROM    ubuntu

RUN     apt-get -y update
RUN     apt-get -y install  python-pip python-twisted git

# Install carbon
RUN     pip install git+git://github.com/graphite-project/whisper@0.9.x &&\
        pip install --install-option="--prefix=/src/carbon" --install-option="--install-lib=/src/carbon/lib" git+git://github.com/graphite-project/carbon@0.9.x

COPY    config/carbon.conf /src/carbon/conf/carbon.conf
COPY    config/storage-schemas.conf /src/carbon/conf/storage-schemas.conf
COPY    config/storage-aggregation.conf /src/carbon/conf/storage-aggregation.conf
COPY    config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN     mkdir -p /data/whisper &&\
        mkdir -p /data/log/ &&\
        chmod 0775 /data /data/whisper

VOLUME  ["/data/whisper"]

CMD     ["/usr/bin/supervisord"]
