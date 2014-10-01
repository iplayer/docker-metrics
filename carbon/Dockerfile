FROM    ubuntu

RUN     apt-get -y update
RUN     apt-get -y install  python-pip python-twisted git

# Install carbon
RUN     pip install git+git://github.com/graphite-project/whisper@0.9.x &&\
        pip install --install-option="--prefix=/src/carbon" --install-option="--install-lib=/src/carbon/lib" git+git://github.com/graphite-project/carbon@0.9.x

ADD     config/carbon.conf /src/carbon/conf/carbon.conf
ADD     config/storage-schemas.conf /src/carbon/conf/storage-schemas.conf
ADD     config/storage-aggregation.conf /src/carbon/conf/storage-aggregation.conf

RUN     mkdir -p /src/carbon/storage/whisper &&\
        chmod 0775 /src/carbon/storage /src/carbon/storage/whisper

VOLUME  ["/src/carbon/storage/whisper"]

CMD     ["/src/carbon/bin/carbon-cache.py", "start"]
