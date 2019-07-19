FROM ubuntu:18.04

WORKDIR ./

COPY ./provision.sh ./
RUN chmod +x ./provision.sh && ./provision.sh


### Entrypoint
ENTRYPOINT ["/sbin/init"]
