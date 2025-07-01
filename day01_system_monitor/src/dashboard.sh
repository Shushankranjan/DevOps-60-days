#!/bin/bash
# Real-time progress bar test (non-looping)

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Progress bar function
create_progress_bar() {
    local percentage=$1
    local width=20
    local filled=$((percentage * width / 100))
    local empty=$((width - filled))
    
    printf "["
    printf "%*s" $filled | tr ' ' '='
    printf "%*s" $empty | tr ' ' '-'
    printf "]"
}

# Get color based on value
get_color() {
    local value=$1
    if [ $value -ge 80 ]; then
        echo -e "${RED}"
    elif [ $value -ge 70 ]; then
        echo -e "${YELLOW}"
    else
        echo -e "${GREEN}"
    fi
}

echo -e "${BLUE}=== REAL-TIME SYSTEM DASHBOARD ===${NC}"
echo "Last Updated: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Get real CPU usage
cpu_usage=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print int(usage)}')
cpu_color=$(get_color $cpu_usage)
echo -e "CPU Usage: ${cpu_color}$(create_progress_bar $cpu_usage) ${cpu_usage}%${NC}"

# Get real Memory usage  
mem_percentage=$(free | awk 'NR==2{printf "%.0f", $3*100/$2}')
mem_color=$(get_color $mem_percentage)
echo -e "Memory Usage: ${mem_color}$(create_progress_bar $mem_percentage) ${mem_percentage}%${NC}"
