FROM centos:centos7

ENV https_proxy "${http_proxy}"
ENV http_proxy "${http_proxy}"
ENV HTTPS_PROXY "${http_proxy}"
ENV HTTP_PROXY "${http_proxy}"

### Basic dev tools.
#RUN sed -i -e "s|#baseurl=|baseurl=|g" \
#           -e "s|mirrorlist=|#mirrorlist=|g" \
#           /etc/yum.repos.d/CentOS-Base.repo

RUN yum clean all
RUN yum -y install epel-release
RUN yum -y update && yum clean all
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

RUN yum install -y \
sudo \
which \
wget \
tall \
tar \
vim \
git \
openssh-server \
openssh-clients \
zip unzip \
net-tools \
git       \
tcpdump


### SSH
RUN mkdir -p  ~/.ssh && \
    touch  ~/.ssh/authorized_keys && \
    chmod 600  ~/.ssh/authorized_keys && \
    echo root | passwd --stdin root


### Local JP
RUN localedef -i ja_JP -f UTF-8 ja_JP.UTF-8
RUN echo 'LANG="ja_JP.UTF-8"' >  /etc/locale.conf
ENV LANG ja_JP.UTF-8

RUN echo 'ZONE="Asia/Tokyo"' > /etc/sysconfig/clock 
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime


### man
RUN sed -i -e"s/^tsflags=nodocs/\# tsflags=nodocs/" /etc/yum.conf
RUN yum -y install man man-pages.noarch man-pages-ja.noarch


### Entrypoint
CMD /bin/bash
