FROM	ubuntu:13.04
ENV 	DEBIAN_FRONTEND noninteractive
RUN		apt-get -y update
RUN 	apt-get install -y -q python-software-properties software-properties-common

# Add nodejs repo
RUN		add-apt-repository ppa:chris-lea/node.js &&\
		apt-get -y update

# Install dependencies
RUN		apt-get -y install  python-django-tagging python-simplejson python-memcache \
							python-ldap python-cairo python-django python-twisted   \
							python-pysqlite2 python-support python-pip gunicorn     \
							supervisor nginx-light nodejs git wget curl

# Setup statsd
RUN		mkdir /src && git clone https://github.com/etsy/statsd.git /src/statsd
ADD		./statsd/config.js /src/statsd/config.js
EXPOSE	8125:8125/udp
EXPOSE	8126:8126

# Install graphite
RUN		pip install https://github.com/graphite-project/ceres/tarball/master &&\
		pip install whisper &&\
		pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/lib" carbon &&\
		pip install --install-option="--prefix=/var/lib/graphite" --install-option="--install-lib=/var/lib/graphite/webapp" graphite-web

# Setup graphite
ADD 	./graphite/initial_data.json /var/lib/graphite/webapp/graphite/initial_data.json
ADD 	./graphite/local_settings.py /var/lib/graphite/webapp/graphite/local_settings.py
ADD 	./graphite/carbon.conf /var/lib/graphite/conf/carbon.conf
ADD 	./graphite/storage-schemas.conf /var/lib/graphite/conf/storage-schemas.conf
RUN		mkdir -p /var/lib/graphite/storage/whisper &&\
		touch /var/lib/graphite/storage/graphite.db /var/lib/graphite/storage/index &&\
		chown -R www-data /var/lib/graphite/storage &&\
		chmod 0775 /var/lib/graphite/storage /var/lib/graphite/storage/whisper &&\
		chmod 0664 /var/lib/graphite/storage/graphite.db &&\
		cd /var/lib/graphite/webapp/graphite && python manage.py syncdb --noinput

# Install grafana
RUN		cd /src &&\
		wget http://grafanarel.s3.amazonaws.com/grafana-1.5.4.tar.gz &&\
		tar -xzvf grafana-1.5.4.tar.gz && rm grafana-1.5.4.tar.gz &&\
		mv grafana-1.5.4 grafana

ADD     ./grafana/config.js /src/grafana/config.js

# Setup nginx
ADD		./nginx/nginx.conf /etc/nginx/nginx.conf
ADD 	./nginx/htpasswd /etc/nginx/htpasswd
EXPOSE	80:80
EXPOSE	8080:8080

# Setup supervisor
ADD		./supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD		["/usr/bin/supervisord"]
