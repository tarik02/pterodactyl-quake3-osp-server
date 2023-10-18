#!/bin/bash
cd /home/container

# Output the current server executable version, if applicable
# For example, if you have a 'quake3-server -version' command or similar, you can use it here.
# quake3-server -version  # This is just an example; replace it with your actual command.

# Replace Startup Variables
# This command uses 'sed' to replace {{VARIABLE}} placeholders with the actual environment variable values.
# It allows Pterodactyl's panel to define startup variables that your server uses.
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
# This command starts up the server with the modified startup command.
${MODIFIED_STARTUP}