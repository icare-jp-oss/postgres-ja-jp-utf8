FROM postgres:14.11
LABEL maintainer="dev@icare.jpn.com"

ENV LANG=ja_JP.utf8

RUN apt-get update -qq && apt-get install -y \
  curl \
  postgresql-server-dev-14 \
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
  && rm -rf ../pg_bigm-1.2-20240606 ../v1.2-20240606.tar.gz

RUN echo "\n\
#listen_addresses = '*'\n\
max_connections = 100\n\
shared_buffers = 160MB\n\
temp_buffers = 16MB\n\
work_mem = 16MB\n\
#dynamic_shared_memory_type = posix\n\
max_worker_processes = 64\n\
max_parallel_maintenance_workers = 8\n\
max_parallel_workers_per_gather = 8\n\
max_parallel_workers = 64\n\
wal_level = minimal\n\
fsync = on\n\
synchronous_commit = on\n\
wal_sync_method = fsync\n\
full_page_writes = on\n\
#max_wal_size = 1GB\n\
#min_wal_size = 80MB\n\
max_wal_senders = 0\n\
random_page_cost = 1.2\n\
jit = off\n\
log_timezone = 'Asia/Tokyo'\n\
stats_temp_directory = '/tmp'\n\
#datestyle = 'iso, ymd'\n\
timezone = 'Asia/Tokyo'\n\
#lc_messages = 'ja_JP.utf8'\n\
#lc_monetary = 'ja_JP.utf8'\n\
#lc_numeric = 'ja_JP.utf8'\n\
#lc_time = 'ja_JP.utf8'\n\
#default_text_search_config = 'pg_catalog.simple'\n\
shared_preload_libraries = 'pg_bigm'\n\
" >>/usr/share/postgresql/12/postgresql.conf.sample
