FROM ubuntu:xenial

USER root

# Install the things needed
RUN apt-get update \
  && apt-get install -yq build-essential \
  && apt-get install -yq libreadline6 libreadline6-dev \
  && apt-get install -yq wget \
  && apt-get install -yq git \
  # Download and build EPICS base
  && wget --quiet https://epics.anl.gov/download/base/base-7.0.7.tar.gz \
  && tar xvzf base-7.0.7.tar.gz \
  && mkdir /opt/epics \
  && mv base-7.0.7 /opt/epics/base \
  && cd /opt/epics/base && make \
  # Download SimpleIoc from git and build it
  && mkdir /opt/epics/iocs \
  && git clone https://github.com/mattclarke/SimpleIoc.git /opt/epics/iocs/SimpleIoc \
  && cd /opt/epics/iocs/SimpleIoc && make

# Expose the standard EPICS and V4 ports
EXPOSE 5064 5065 5064/udp 5075 5076 5075/tcp 5076/udp

# Start the IOC
CMD cd /opt/epics/iocs/SimpleIoc/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd
