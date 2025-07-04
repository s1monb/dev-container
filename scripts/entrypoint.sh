#!/bin/bash
# This script is run as root

# When developing within a docker-container, you need to match the UID and GID of the user
# on the host system. This is done by passing the PUID and PGID as build arguments.
# The default values are set to 1000, which is the default UID and GID for the first user (ubuntu).
export XDG_CONFIG_HOME="/home/dev/.config"
export XDG_DATA_HOME="/home/dev/.local/share"
export XDG_CACHE_HOME="/home/dev/.cache"
export XDG_STATE_HOME="/home/dev/.local/state"

# If you are running this script as a non GUID=1000 (ubuntu-user) user, you need to set the PUID and PGID environment variables
# TODO: Describe this better
if [ "$PUID" != $(id -u dev) ]; then    
	userdel dev
    groupadd -g "$PGID" dev 
    useradd -u "$PUID" -g "$PGID" -m -s /bin/fish dev

    chown -R dev:dev /home/dev 
	chown -R dev:dev /home/linuxbrew    
fi

# CAUTION: If you change this line, make sure to not break the window 
su dev --session-command "fish" -c "tmux" 
