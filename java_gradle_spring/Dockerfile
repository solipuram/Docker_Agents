FROM ubuntu:18.04


##################################################
####  update ubuntu  
##################################################
RUN apt-get update -y && \
    apt-get install -y curl && \
    apt-get install -y wget && \
    apt-get install -y libexpat1 && \
    apt-get install -y libsasl2-2 && \
    apt-get install -y libssl1.1 && \
    apt-get install -y openssl && \
    apt-get install unzip && \
    apt-get install zip 


###################################
#### ---- Install JAVA ---- #####
###################################

ARG JAVA_VERSION=11
ENV JAVA_VERSION=${JAVA_VERSION:-11}
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


###################################
#### ---- Install Gradle ---- #####
###################################
# Ref: https://gradle.org/releases/

ARG GRADLE_INSTALL_BASE=${GRADLE_INSTALL_BASE:-/opt/gradle}
ARG GRADLE_VERSION=${GRADLE_VERSION:-5.0}

ARG GRADLE_HOME=${GRADLE_INSTALL_BASE}/gradle-${GRADLE_VERSION}
ENV GRADLE_HOME=${GRADLE_HOME}
ARG GRADLE_PACKAGE=gradle-${GRADLE_VERSION}-bin.zip
ARG GRADLE_PACKAGE_URL=https://services.gradle.org/distributions/${GRADLE_PACKAGE}

RUN mkdir -p ${GRADLE_INSTALL_BASE} && \
    cd ${GRADLE_INSTALL_BASE} && \
    wget -q --no-check-certificate -c ${GRADLE_PACKAGE_URL} && \
    unzip -d ${GRADLE_INSTALL_BASE} ${GRADLE_PACKAGE} && \
    ls -al ${GRADLE_HOME} && \
    ln -s ${GRADLE_HOME}/bin/gradle /usr/bin/gradle && \
    ${GRADLE_HOME}/bin/gradle -v && \
    rm -f ${GRADLE_PACKAGE}
    
##it's for debug purpose later will remove

RUN java --version && \
    gradle --version 
    

CMD ["\bin\bash"]