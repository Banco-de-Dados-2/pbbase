@echo off
pg_dump -U postgres -w -f %1\bancobatch%2.backup banco2 >nul >2&1