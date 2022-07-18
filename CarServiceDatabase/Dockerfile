FROM postgres:alpine
COPY Scripts/ /docker-entrypoint-initdb.d/
RUN chmod a+r /docker-entrypoint-initdb.d/* 