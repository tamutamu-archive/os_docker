FROM ubuntu:18.04

WORKDIR ./

COPY ./base_install.sh ./
RUN chmod +x ./base_install.sh && ./base_install.sh


### Entrypoint
CMD /bin/bash
