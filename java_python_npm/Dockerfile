FROM ubuntu:18.04



#### ---------------------
#### ---- USER, GROUP ----
#### ---------------------
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

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
####  Install Python 3 
##################################################
#ARG LIB_PYTHON_LIST="apt-utils software-properties-common python3.6 openssl 3.0.2"
RUN apt-get update -y && \
    apt-get install -y  software-properties-common && \
    apt-get install -y  python3.6 && \
    apt-get install -y python3-pip && \
    apt-get install -y python3-setuptools 

    
  
##################################################
####  Install Open JDK 
##################################################

ARG JAVA_VERSION=8
ENV JAVA_VERSION=${JAVA_VERSION:-8}
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
ARG OPENJDK_PACKAGE=${OPENJDK_PACKAGE:-openjdk-${JAVA_VERSION}-jdk}
ARG OPENJDK_INSTALL_LIST=${OPENJDK_PACKAGE:-openjdk-${JAVA_VERSION}-jdk}


RUN apt-get update -y && \
    apt-get install -y ${OPENJDK_INSTALL_LIST} && \
    ls -al ${JAVA_HOME} && \
    export PATH=$PATH ; echo "PATH=${PATH}" ; export JAVA_HOME=${JAVA_HOME} ; echo "java=`which java`" && \
    apt-get clean -y &&\
    rm -rf /var/lib/apt/lists/*

    
#########################################
#### ---- Node from NODESOURCES ---- ####
#########################################

ARG NODE_VERSION=${NODE_VERSION:-16}
ENV NODE_VERSION=${NODE_VERSION}
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    npm install -g npm@latest && \
rm -rf /var/lib/apt/lists/*


###################################
#### ---- user: developer ---- ####
###################################
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}
ENV USER=${USER:-developer}
ENV HOME=/home/${USER}

## -- setup NodeJS user profile
RUN groupadd ${USER} && useradd ${USER} -m -d ${HOME} -s /bin/bash -g ${USER} && \
    ## -- Ubuntu -- \
    usermod -aG sudo ${USER} && \
    echo "${USER} ALL=NOPASSWD:ALL" | tee -a /etc/sudoers && \
    echo "USER =======> ${USER}" && ls -al ${HOME}


##it's for debug purpose later will remove

RUN java -version && \
    python3 -V && \
    node --version  && \
    npm --version && \
    curl --version


CMD ["\bin\bash"]