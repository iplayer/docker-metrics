# iPlayer metrics
Docker container with:

* statsd
* carbon
* graphite
* grafana
* elasticsearch

Grafana is on port 80, graphite on port 8080.

## To build
If you want to protect the grafana end points generate a htpasswd file in the nginx directory before building. Similarly check the other directories for other configuration options.

```bash
sudo ./build
```

## To run
```bash
sudo ./start
```


Based on https://github.com/SamSaffron/graphite_docker
