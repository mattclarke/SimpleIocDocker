FROM ubuntu:artful

USER root

# Install the things needed
RUN apt-get update
RUN apt-get install -yq build-essential
RUN apt-get install -yq libreadline6 libreadline6-dev
RUN apt-get install -yq wget
RUN apt-get install -yq git

# Download and build EPICS base
RUN wget --quiet https://epics.anl.gov/download/base/base-3.15.5.tar.gz
RUN tar xvzf base-3.15.5.tar.gz
RUN mkdir /opt/epics
RUN mv base-3.15.5 /opt/epics/base
RUN cd /opt/epics/base && make

# Download and build EPICS V4
RUN wget --quiet https://sourceforge.net/projects/epics-pvdata/files/4.6.0/EPICS-CPP-4.6.0.tar.gz
RUN tar xvzf EPICS-CPP-4.6.0.tar.gz
RUN mv EPICS-CPP-4.6.0 /opt/epics/V4
# Skip building the examples
RUN cd /opt/epics/V4 && sed -i 's/MODULES += exampleCPP/# MODULES += exampleCPP/g' Makefile
RUN cd /opt/epics/V4 && make EPICS_BASE=/opt/epics/base

# Download SimpleIoc from git and build it
RUN mkdir /opt/epics/iocs
RUN git clone https://github.com/mattclarke/SimpleIoc.git /opt/epics/iocs/SimpleIoc
RUN cd /opt/epics/iocs/SimpleIoc && make

# Expose the standard EPICS and V4 ports
EXPOSE 5064 5065 5075 5076
EXPOSE 5064/udp 5076/udp

# Start the IOC
CMD cd /opt/epics/iocs/SimpleIoc/iocBoot/iocSimpleIoc/ && ../../bin/linux-x86_64/SimpleIoc st.cmd
