#!/bin/sh
exec /usr/bin/supervisord >> /var/log/supervisord.log 2>&1

