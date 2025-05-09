#!/bin/bash

# Check for argument
if [ -z "$1" ]; then
  echo "Usage: $0 <log-directory>"
  # error message
  exit 1
  # exits script
fi

LOG_DIR=$1 # store user specified directory

# Check if log directory exists
if [ ! -d "$LOG_DIR" ]; then
  echo "Error: Directory '$LOG_DIR' does not exist."
  exit 1
fi

ARCHIVE_DIR="./archives"                        # destination directory
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")              # generate date timestamp
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz" # constructs the file name

# Create archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Create the archive
tar -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .
# tar -c create -z compress with gzip -f file name follows
# -C change the directory before archiving (VERY IMPORTANT)
# The archive only contains the files, not the full system paths.
# It's portable: you can extract it anywhere without pollUting other folders.
# Prevents permission issues when restoring or extracting.

# Log the operation into archive_log.txt, appending a line at the end
echo "[$(date +"%Y-%m-%d %H:%M:%S")] Archived $LOG_DIR to ${ARCHIVE_DIR}/${ARCHIVE_NAME}" >>archive_log.txt

echo "Archive created: ${ARCHIVE_DIR}/${ARCHIVE_NAME}"
