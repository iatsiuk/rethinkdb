FROM ubuntu:21.10

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  g++ \
  protobuf-compiler \
  libprotobuf-dev \
  libboost-dev \
  curl \
  m4 \
  wget \
  libssl-dev \
  clang \
  python \
  make \
  patch \
  unzip \
  python3-pip && \
  pip install rethinkdb

COPY rethinkdb-2.4.2.zip /tmp/rethinkdb.zip

RUN cd /tmp && \
  unzip /tmp/rethinkdb.zip && \
  cd rethinkdb-2.4.2 && \
  ./configure --allow-fetch CXX=clang++ && \
  make install && \
  cd / && \
  rm -rf /tmp/rethinkdb*

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

EXPOSE 28015 29015 8080
