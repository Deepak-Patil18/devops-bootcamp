#!/bin/bash

SOURCE_DIR=$HOME/devops-bootcamp
BACKUP_DIR=$HOME/backups
LOG_FILE=$HOME/backups/backup.log
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_NAME="backup_${DATE}.tar.gz"
KEEP_DAYS=7

RED=$'\033[0;31m'
GREEN=$'\033[0;32m'
NC=$'\033[0m'

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') $1" | tee -a $LOG_FILE
}

cleanup_old_backups() {
    log "Cleaning backups older than $KEEP_DAYS days..."
    COUNT=$(find $BACKUP_DIR -name 'backup_*.tar.gz' -mtime +$KEEP_DAYS | wc -l)
    find $BACKUP_DIR -name 'backup_*.tar.gz' -mtime +$KEEP_DAYS -delete
    log "Removed $COUNT old backup(s)"
}

mkdir -p $BACKUP_DIR

log '======================================='
log 'Starting backup...'
log "Source: $SOURCE_DIR"

tar -czf $BACKUP_DIR/$BACKUP_NAME $SOURCE_DIR 2>/dev/null

if [ $? -eq 0 ]; then
    SIZE=$(du -sh $BACKUP_DIR/$BACKUP_NAME | cut -f1)
    log "${GREEN}SUCCESS: Backup created — $BACKUP_NAME (Size: $SIZE)${NC}"
else
    log "${RED}FAILED: Backup creation failed!${NC}"
    exit 1
fi

cleanup_old_backups

log 'Backup complete!'
log '======================================='
