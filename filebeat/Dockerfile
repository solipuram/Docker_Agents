# Build FROM our base rh-ubi8 
FROM RHEL


ENV FILEBEAT_VERSION=6.2.3 \
    FILEBEAT_SHA1=9c87d44e47fb2e48f9d772449a72de5148d83b2e906ec673e4832d2d284ecc9643a6ca4df6600d30b79558c2ca233b94a88c2a3e4e195f2d396bdbbdcf4b6689

RUN set -x && \
  yum update -y && \
  yum install -y wget && \
  wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz -O /opt/filebeat.tar.gz && \
  cd /opt && \
  echo "${FILEBEAT_SHA1}  filebeat.tar.gz" | sha512sum -c - && \
  tar xzvf filebeat.tar.gz && \
  cd filebeat-* && \
  cp filebeat /bin && \
  cd /opt && \
  rm -rf filebeat* && 
 
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "filebeat", "-e" ]