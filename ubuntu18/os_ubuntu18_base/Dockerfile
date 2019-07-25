FROM ubuntu:18.04

WORKDIR ./

COPY ./provision.sh ./
RUN chmod +x ./provision.sh && ./provision.sh


STOPSIGNAL SIGRTMIN+3

# Workaround for docker/docker#27202, technique based on comments from docker/docker#9212
CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
