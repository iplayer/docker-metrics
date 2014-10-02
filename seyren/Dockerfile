FROM dockerfile/java:oracle-java7

ADD https://github.com/scobal/seyren/releases/download/1.1.0/seyren-1.1.0.jar /opt/seyren.jar
ADD config/run-seyren.sh /usr/bin/run-seyren.sh
RUN chmod +x /usr/bin/run-seyren.sh

ENTRYPOINT ["/usr/bin/run-seyren.sh"]
EXPOSE 8888
