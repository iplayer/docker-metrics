FROM    ubuntu

RUN     apt-get -y update
RUN     apt-get install -y -q python-software-properties software-properties-common supervisor

RUN     apt-get -y install  python-django-tagging python-simplejson python-memcache \
                            python-ldap python-cairo python-django python-pip  \
                            python-pysqlite2 python-support python-pip gunicorn     \
                            git memcached

# Install graphite
RUN     pip install --install-option="--prefix=/src/graphite" --install-option="--install-lib=/src/graphite/webapp" git+git://github.com/graphite-project/graphite-web@0.9.x

# Setup graphite
COPY    config/local_settings.py /src/graphite/webapp/graphite/local_settings.py
COPY    config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN     touch /src/graphite/storage/graphite.db /src/graphite/storage/index &&\
        chown -R www-data /src/graphite/storage &&\
        chmod 0775 /src/graphite/storage &&\
        chmod 0664 /src/graphite/storage/graphite.db &&\
        cd /src/graphite/webapp/graphite && python manage.py syncdb --noinput

VOLUME  ["/var/log"]
EXPOSE  8080

CMD     ["/usr/bin/supervisord"]
