#!/bin/bash
# This script is run as root

# When developing within a docker-container, you need to match the UID and GID of the user
# on the host system. This is done by passing the PUID and PGID as build arguments.
# The default values are set to 1000, which is the default UID and GID for the first user (ubuntu).
export USERNAME="ubuntu"
export XDG_CONFIG_HOME="/home/ubuntu/.config"

# If you are running this script as a non GUID=1000 user, you need to set the PUID and PGID environment variables
# TODO: Describe this better
if !id -u "1000" >/dev/null 2>&1; then
    if id -u "$PUID" >/dev/null 2>&1; then
        exit
    fi
    useradd -u "$PUID" -m -s /bin/fish dev
    groupadd -g "$PGID" devgroup
    echo "User with UID $PUID and GID $PGID created"
    cp -r /home/ubuntu/* /home/dev/
    chown -R dev:devgroup /home/dev
    chown -R dev:devgroup /home/linuxbrew

    export XDG_CONFIG_HOME="/home/dev/.config"
    export USERNAME="dev"
fi

# CAUTION: If you change this line, make sure to not break the window 
# resize-capabilities between your terminal and tmux
su $USERNAME --session-command "fish" -c "tmux" 
