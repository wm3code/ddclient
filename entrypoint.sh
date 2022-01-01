## Shell script to start ddclient
#!/bin/bash

# Start ddclient
service ddclient start &

# Make sure it logs
tail -F /var/log/ddclient.log

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
