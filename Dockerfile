FROM fedora:latest
ARG http_proxy
ARG https_proxy
RUN yum makecache
RUN yum -y install \
    gcc gcc-c++ make boost-devel libxslt
RUN yum -y install \
    asciidoc
# RUN yum -y install \
#     ncurses-devel
