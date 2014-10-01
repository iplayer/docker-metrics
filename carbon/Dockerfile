FROM    ubuntu

RUN     apt-get -y update
RUN     apt-get -y install  python-pip git

# Install graphite
RUN     pip install git+git://github.com/graphite-project/whisper@0.9.x &&\
        pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/lib" git+git://github.com/graphite-project/carbon@0.9.x

ADD     config/carbon.conf /src/graphite/conf/carbon.conf
ADD     config/storage-schemas.conf /src/graphite/conf/storage-schemas.conf
ADD     config/storage-aggregation.conf /src/graphite/conf/storage-aggregation.conf

RUN     mkdir -p /src/graphite/storage/whisper &&\
        chown -R www-data /src/graphite/storage &&\
        chmod 0775 /src/graphite/storage /src/graphite/storage/whisper

VOLUME  ["/src/graphite/storage/whisper"]

CMD     ["/src/graphite/bin/carbon-cache.py start"]
