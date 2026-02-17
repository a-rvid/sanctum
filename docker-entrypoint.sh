#!/bin/ash

syslogd
hymn up
tail -f /var/log/messages &
wait