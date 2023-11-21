#!/bin/bash

# This script is designed to copy and execute a Python script from a master server to a local server.
# It logs the operations to a file and captures the output of the Python script.
# Before using this script in automation tools like Cronicle, ensure that an SSH connection 
# has been established between the local server and the master server.
# This requires setting up SSH keys for password-less login from the local server to the master server.

# Define variables for the master server and the script to be executed.
# MASTER_USER: The username to log into the master server.
# MASTER_SERVER: The IP address or hostname of the master server.
# SCRIPT_NAME: The name of the Python script to be copied and executed.
# SCRIPT_PATH: The path to the Python script on the master server.
# LOCAL_SCRIPT_PATH: The path where the script will be copied to on the local server.
MASTER_USER="root"
MASTER_SERVER="192.168.1.20"
SCRIPT_NAME="calc_fac.py"
SCRIPT_PATH="/scripts/${SCRIPT_NAME}"
LOCAL_SCRIPT_PATH="/tmp/${SCRIPT_NAME}"

# The log file where script operations will be logged.
LOG_FILE="/var/log/rss_consumption.log"

# Check if the log file exists, if not, create it.
if [ ! -f "$LOG_FILE" ]; then
    touch "$LOG_FILE"
fi

# Log the start of the operation.
echo "[$(date)] Starting to copy and execute Python script" >> $LOG_FILE

# Copy the script from the master server to the local server using SCP (Secure Copy Protocol).
scp ${MASTER_USER}@${MASTER_SERVER}:${SCRIPT_PATH} ${LOCAL_SCRIPT_PATH} 2>> $LOG_FILE

# Check if the SCP command was successful.
if [ $? -eq 0 ]; then
    # Log successful copy.
    echo "[$(date)] Script copied successfully" >> $LOG_FILE

    # Execute the copied Python script and capture its output.
    python3 ${LOCAL_SCRIPT_PATH} > output.log 2>> $LOG_FILE

    # Check if the Python script was executed successfully.
    if [ $? -eq 0 ]; then
        # Log successful execution.
        echo "[$(date)] Script executed successfully" >> $LOG_FILE
    else
        # Log any execution error.
        echo "[$(date)] Error in script execution" >> $LOG_FILE
    fi
else
    # Log any error encountered during the SCP command.
    echo "[$(date)] Error in copying script from master server" >> $LOG_FILE
fi

# Final log entry indicating the operation is completed.
echo "[$(date)] Operation completed" >> $LOG_FILE
