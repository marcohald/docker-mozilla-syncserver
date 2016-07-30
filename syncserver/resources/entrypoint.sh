#!/bin/bash

dockerize -template $CONFIG_HOME/syncserver.ini.j2:$CONFIG_HOME/syncserver.ini

/usr/local/share/syncserver/local/bin/gunicorn --threads 4 --paste $CONFIG_HOME/syncserver.ini
