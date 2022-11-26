FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBIAN_FRONTEND teletype

##################################################
####  update ubuntu  
##################################################
RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get install -y libexpat1 && \
    apt-get install -y libsasl2-2 && \
    apt-get install -y libssl1.1 && \
    apt-get install -y openssl

##################################################
####  Common utiliities   
##################################################
RUN apt-get install -y init && \
    apt-get install -y git  && \
    apt-get install -y make && \
    apt-get install -y wget && \
    apt-get install -y htmldoc && \
    apt-get install -y libxml-writer-perl && \
    apt-get install -y libarchive-zip-perl && \
    apt-get install -y libjson-perl && \
    apt-get install -y linux-libc-dev 
    



##################################################
####  Install Python 3 
##################################################
RUN apt-get update -y && \
    apt-get install -y  software-properties-common && \
    apt-get install -y  python3 && \
    apt-get install -y  python3-pip
    
  
##################################################
####  Install Ansible
##################################################
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update -y && \
    apt-get install ansible -y


##################################################
#### ## Copy scripts
##################################################
COPY scripts /scripts

#########################################
#### ---- Install Lynis ---- ####
#########################################

RUN git clone -b 3.0.6 https://github.com/CISOfy/lynis.git

RUN ["/bin/bash", "-c", "pushd /tmp/"]
RUN wget http://search.cpan.org/CPAN/authors/id/M/MF/MFRANKL/HTML-HTMLDoc-0.10.tar.gz
RUN tar xvf HTML-HTMLDoc-0.10.tar.gz
RUN ["/bin/bash", "-c", "pushd HTML-HTMLDoc-0.10"] ; perl Makefile.PL ; make && make install ; popd
RUN wget http://search.cpan.org/CPAN/authors/id/J/JM/JMCNAMARA/Excel-Writer-XLSX-0.95.tar.gz
RUN tar xvf Excel-Writer-XLSX-0.95.tar.gz
RUN ["/bin/bash", "-c", "pushd Excel-Writer-XLSX-0.95"] ; perl Makefile.PL ; make && make install ; popd ; popd
RUN git clone https://github.com/d4t4king/lynis-report-converter.git
RUN cd /scripts ; sh apply_hardening_scripts.sh
CMD [ "/sbin/init" ]
