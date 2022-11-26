FROM ubuntu:18.04


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
ARG LIB_BASIC_LIST="iputils-ping nmap net-tools build-essential software-properties-common "
ARG LIB_COMMON_LIST="bzip2 libbz2-dev git wget unzip vim python3-pip python3-setuptools python3-dev python3-venv python3-numpy python3-scipy python3-pandas python3-matplotlib"
ARG LIB_TOOL_LIST="libsqlite3-dev sqlite3"
RUN apt-get update -y && \
    apt-get install -y ${LIB_BASIC_LIST} && \
    apt-get install -y ${LIB_COMMON_LIST} && \
    apt-get install -y ${LIB_TOOL_LIST} && \
    apt-get clean -y
    
########################################
#### ---- PIP install packages ---- ####
########################################
COPY requirements.txt ./

# pip3 uninstall pkg-resources==0.0.0
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip --no-cache-dir install --ignore-installed -U -r requirements.txt

## -- added Local PIP installation bin to PATH
ENV PATH=${PATH}:${HOME}/.local/bin

## VERSIONS ##
ENV PATH=${PATH}:${JAVA_HOME}/bin

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
#### ---- Update: all     ---- ####
###################################
RUN apt-get update -y && apt upgrade -y

RUN apt-get --yes --force-yes -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install sudo

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


############################################
#### ---- Set up user environments ---- ####
############################################
ENV WORKSPACE=${HOME}/workspace
ENV DATA=${HOME}/data

WORKDIR ${HOME}
RUN find / -name "instantclient_21_3"

RUN mkdir instantclient_21_3
RUN ls -al /home/developer/

COPY /instantclient_21_3/ /home/developer/instantclient_21_3
RUN ls -al /home/developer/
RUN ls -al /home/developer/instantclient_21_3
##ADD https://git.nexgen.neustar.biz/a209077/java-python-npm-replica/tree/dev/instantclient_21_3 /home/developer/instantclient_21_3


############################################
#### ---- Volumes: data, workspace ---- ####
############################################
RUN mkdir -p ${WORKSPACE} ${DATA}
RUN chown ${USER}:${USER} -R  ${DATA}
RUN chown ${USER}:${USER} -R  ${HOME}

RUN chmod 0755 /home/developer/instantclient_21_3
RUN ls -al 

RUN ls -al ${HOME}


VOLUME ${DATA}
VOLUME ${WORKSPACE}



#########################
#### ---- Entry ---- ####
#########################
USER ${USER}
WORKDIR ${HOME}

CMD ["/bin/bash"]