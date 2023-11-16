psql -u "alter system set archive_command='copy "%p" "C:\\wal_archive\\%f"'" postgres
psql -u "alter system set archive_mode='on'" postgres
psql -u "alter system set archive_timeout='600'" postgres
psql -u "alter system set wal_keep_size='100 MB'" postgres
psql -u "alter system set wal_level='replica'" postgres
psql -u "alter system set wal_segment_size=''" postgres