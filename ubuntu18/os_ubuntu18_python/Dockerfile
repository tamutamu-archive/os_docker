FROM os_ubuntu18_base:latest

WORKDIR ./

COPY ./provision.sh ./
RUN chmod +x ./provision.sh && ./provision.sh


### Entrypoint
CMD /bin/bash
