#!/bin/bash
# Backup Script

BACKUP_DIR="/backups/user"
SOURCE_DIR="/home/user/"

# Check if backup directory exists, create it if it doesn't
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Create a timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M")

# Perform the backup
tar -czf $BACKUP_DIR/backup-$TIMESTAMP.tar.gz $SOURCE_DIR