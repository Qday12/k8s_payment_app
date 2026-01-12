#!/bin/bash

# Configuration
BACKUP_DIR="/var/backups/postgresql"
DB_NAME="paymentdb"
DB_USER="dbadmin"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.sql"

PG_DUMP="/usr/bin/pg_dump"

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Perform backup
export PGPASSWORD='IUB+[63wwzKKCB3Ud%ZrnVAvklHW[Z*m'
"$PG_DUMP" \
-h localhost \
-U "$DB_USER" \
-d "$DB_NAME" \
-f "$BACKUP_FILE"