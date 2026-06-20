#!/bin/bash

echo "=========================================="
echo " Log Cleanup Started: $(date)"
echo "=========================================="

echo ""
echo "===== Disk Usage Before Cleanup ====="
df -Th


for HOMEDIR in /home*; do
    [ -d "$HOMEDIR" ] || continue

    echo ""
    echo "===== Processing $HOMEDIR ====="

    echo "Clearing public_html error_log files..."
    find "$HOMEDIR"/*/public_html -type f -name "error_log" -exec truncate -s 0 {} \;

    echo "Clearing account error.log files..."
    find "$HOMEDIR"/*/logs -type f -name "*error.log" -exec truncate -s 0 {} \;

    echo "Removing compressed log files (*.gz)..."
    find "$HOMEDIR"/*/logs -type f -name "*.gz" -print -delete > /dev/null


    echo "Removing sess files (sess_*)..."
    find "$HOMEDIR"/*/tmp -type f -name "sess_*" -print -delete > /dev/null

    echo "Clearing Razor agent logs..."
    find "$HOMEDIR"/*/.razor -type f -name "razor-agent.log" -exec truncate -s 0 {} \;

    echo "Clearing Analog cache files..."
    find "$HOMEDIR"/*/tmp/analog -type f -name "cache" -exec truncate -s 0 {} \;

    echo "Clearing Laravel logs..."
    find "$HOMEDIR"/*/public_html -type f -name "laravel.log" -exec truncate -s 0 {} \;

    echo "Clearing Debug log..."
    find "$HOMEDIR"/*/public_html -type f -name "debug.log" -exec truncate -s 0 {} \;
done

echo ""
echo "===== Apache Logs ====="

echo "Clearing Apache domlogs..."
#find /var/log/apache2/domlogs -type f -name "*_log" -exec truncate -s 0 {} \;
find /var/log/apache2 -type f -name "*_log" -exec truncate -s 0 {} \;
find /var/log/apache2 -type f -name "*.log" -exec truncate -s 0 {} \;

echo "Removing compressed Apache logs..."
find /var/log/apache2 -type f -name "*.gz" -print -delete > /dev/null


echo ""
echo "===== imunify360 ====="

echo "Removing compressed imunify360 logs..."
find /var/log/imunify360 -type f -name "*.gz" -print -delete > /dev/null
find /var/log/imunify360-webshield -type f -name "*.gz" -print -delete > /dev/null

echo "Clearing imunify360..."
find /var/log/imunify360 -type f -name "*.log" -exec truncate -s 0 {} \;
find /var/log/imunify360 -type f -name "*.log*" -exec truncate -s 0 {} \;
find /var/log/imunify360-webshield -type f -name "*.log" -exec truncate -s 0 {} \;

echo ""
echo "===== bitninja ====="

echo "Removing compressed bitninja logs..."
find /var/log/bitninja -type f -name "*.gz" -print -delete > /dev/null
find /var/log/bitninja-dispatcher -type f -name "*.gz" -print -delete > /dev/null

echo "Clearing bitninja..."
find /var/log/bitninja -type f -name "*.log" -exec truncate -s 0 {} \;
find /var/log/bitninja -type f -name "*.log*" -exec truncate -s 0 {} \;
find /var/log/bitninja-dispatcher -type f -name "*.log" -exec truncate -s 0 {} \;

echo ""
echo "===== Jetbackup ====="

echo "Clearing jetbackup..."
find /usr/local/jetapps/var/log -type f -name "*.log" -exec truncate -s 0 {} \;
find /usr/local/jetapps/var/log -type f -name "*.log*" -exec truncate -s 0 {} \;
find /usr/local/jetapps/var/log -type f -name "*.gz" -print -delete > /dev/null

echo ""
echo "===== PHP Sessions ====="

echo "Deleting PHP session files older than 120 minutes..."
find /var/cpanel/php/sessions/* -type f -mmin +120 -print -delete > /dev/null

echo ""
echo "=========================================="
echo " Log Cleanup Completed: $(date)"
echo "=========================================="

echo ""
echo "===== Disk Usage After Cleanup ====="
df -Th
echo "=========================================="
