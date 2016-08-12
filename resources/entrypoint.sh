#!/bin/bash

#if settings-file not existing, template it
[ ! -f $CONFIG_HOME/syncserver.ini ] && dockerize -template $CONFIG_HOME/syncserver.ini.j2:$CONFIG_HOME/syncserver.ini

# run sync-server
./local/bin/gunicorn --paste $CONFIG_HOME/syncserver.ini
