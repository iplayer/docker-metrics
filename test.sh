#!/bin/bash

while true
do
  value="$(((RANDOM % 10) + 1))"
  echo $value
  # echo "example.carbon.counter.changed $value `date -d -${value}min +%s`" | nc localhost 2003
  echo -n "example.statsd.counter.changed:$value|c" | nc -w 1 -u localhost 8125
  sleep 1
done