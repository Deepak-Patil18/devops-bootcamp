#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
print_section() {
echo ''
echo "${BLUE}================================${NC}"
echo "${BLUE}  $1${NC}"
echo "${BLUE}================================${NC}"
}
echo "System Report — Generated: $(date)"
echo "Hostname: $(hostname) | User: $(whoami)"
print_section 'SYSTEM INFORMATION'
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo "CPU Cores: $(nproc)"
print_section 'MEMORY USAGE'
free -h
MEM_TOTAL=$(free | grep Mem | awk '{print $2}')
MEM_USED=$(free | grep Mem | awk '{print $3}')
MEM_PCT=$(( MEM_USED * 100 / MEM_TOTAL ))
echo "Memory Used: ${MEM_PCT}%"
print_section 'DISK USAGE'
df -h
DISK_PCT=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
echo "Root disk used: ${DISK_PCT}%"
print_section 'TOP 5 PROCESSES BY CPU'
ps aux --sort=-%cpu | head -6
print_section 'DOCKER STATUS'
if command -v docker &> /dev/null; then
echo "Docker version: $(docker --version)"
echo "Running containers: $(docker ps -q 2>/dev/null | wc -l)"
else
echo 'Docker: not installed'
fi
echo ''
echo "Report complete — $(date '+%H:%M:%S')"
