# Build FROM our base rh-ubi8 
FROM baseImage 

# Set a unique cache serial, to force cache refresh when needed
ENV REFRESHED_AT="2021-06-12"

ENV BASE_DIR=node_exporter-1.3.1.linux-amd64
COPY ${BASE_DIR}/node_exporter  /bin/node_exporter

USER       nobody
EXPOSE      9100
USER        nobody
ENTRYPOINT  [ "/bin/node_exporter" ]
