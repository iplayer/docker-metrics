FROM    ubuntu

RUN     apt-get -y update
RUN     apt-get install -y -q python-software-properties software-properties-common

RUN     apt-get -y install  python-django-tagging python-simplejson python-memcache \
                            python-ldap python-cairo python-django python-twisted   \
                            python-pysqlite2 python-support python-pip gunicorn     \
                            git memcached

# Install graphite
RUN     pip install https://github.com/graphite-project/ceres/tarball/master &&\
        pip install git+git://github.com/graphite-project/whisper@0.9.x &&\
        pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/lib" git+git://github.com/graphite-project/carbon@0.9.x &&\
        pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/webapp" git+git://github.com/graphite-project/graphite-web@0.9.x


# Setup graphite
ADD     config/local_settings.py /src/graphite/webapp/graphite/local_settings.py
ADD     config/carbon.conf /src/graphite/conf/carbon.conf
ADD     config/storage-schemas.conf /src/graphite/conf/storage-schemas.conf
ADD     config/storage-aggregation.conf /src/graphite/conf/storage-aggregation.conf
RUN     mkdir -p /src/graphite/storage/whisper &&\
        touch /src/graphite/storage/graphite.db /src/graphite/storage/index &&\
        chown -R www-data /src/graphite/storage &&\
        chmod 0775 /src/graphite/storage /src/graphite/storage/whisper &&\
        chmod 0664 /src/graphite/storage/graphite.db &&\
        cd /src/graphite/webapp/graphite && python manage.py syncdb --noinput

VOLUME  ["/src/graphite/storage/whisper"]

EXPOSE  2003
EXPOSE  2004
EXPOSE  8080
