FROM    dockerfile/nodejs

RUN     git clone git://github.com/etsy/statsd.git statsd
COPY    config/config.js ./statsd/config.js

EXPOSE  8125/udp 8126/tcp

CMD     ["node", "statsd/stats.js", "statsd/config.js"]
