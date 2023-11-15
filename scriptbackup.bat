@echo off
pg_dump -U postgres -w -f c:\dump\bancobatch%1.backup banco2 >nul >2&1