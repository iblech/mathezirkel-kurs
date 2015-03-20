#!/bin/bash

apt-get remove owncloud-client
apt-get install vnc4server vncviewer lxde kate openssh-server
# passwd iblech nicht vergessen

# In .vnc/xstartup:
# lxsession

# Dann:
# env -u SESSION_MANAGER -u DBUS_SESSION_BUS_ADDRESS vnc4server -geometry 1980x1020
