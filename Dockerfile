FROM postgres:15.13
LABEL maintainer="dev@icare.jpn.com"

ENV LANG=ja_JP.utf8

# 各種必要なライブラリをインストール
RUN apt-get update -qq && apt-get install -y \
  curl \
  postgresql-server-dev-15 \
  make \
  gcc \
  libicu-dev \
  ca-certificates \
  && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 \
  && curl -OL https://github.com/pgbigm/pg_bigm/archive/refs/tags/v1.2-20240606.tar.gz \
  && tar zxf v1.2-20240606.tar.gz \
  && cd pg_bigm-1.2-20240606 \
  && make USE_PGXS=1 \
  && make USE_PGXS=1 install \
  && rm -rf ../pg_bigm-1.2-20240606 ../v1.2-20240606.tar.gz \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# conf.d ディレクトリをコンテナにコピー
COPY conf.d /etc/postgresql/conf.d

# postgresql.conf.sample の末尾に include_dir を追記
RUN echo "\ninclude_dir '/etc/postgresql/conf.d'" >> /usr/share/postgresql/postgresql.conf.sample
