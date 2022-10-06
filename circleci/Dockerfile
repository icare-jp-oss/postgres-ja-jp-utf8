FROM cimg/postgres:12.11
LABEL maintainer="dev@icare.jpn.com"
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG=ja_JP.utf8
RUN echo "\
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
fsync = off\n\
synchronous_commit = off\n\
wal_sync_method = fsync\n\
full_page_writes = off\n\
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
" >>/usr/share/postgresql/12/postgresql.conf.sample
