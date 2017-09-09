FROM debian:latest
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y install gcc g++ make libboost-dev libncursesw5-dev libboost-regex-dev xsltproc
RUN apt-get -y --no-install-recommends install asciidoc

