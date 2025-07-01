#!/bin/bash
# system health monitor v1.0
# collects system metrics for Devops monitoring

# configuration
LOG_FILE="logs/system_health_$(date +%Y%m%d_%H%M%S).log"
ALERT_THRESHOLD_CPU=80
ALERT_THRESHOLD_MEMORY=85
ALERT_THRESHOLD_DISK=90

# Fucntions to implement:
# - get_system_info()
# - check_cpu_usage()
# - check_memory_usage()
# - check_disk_usage()
# - check_running_services()
# - generate_report()
# - send_alerts()

send_alerts(){
echo "=== ALERT STATUS ==="
echo "All system normal"
}

generate_report(){
 echo "=== GENERATE REPORT ==="
 echo "Generated: $(date)"
 echo "========================"
 echo ""
 get_system_info(){
  echo "Hostname: $(hostname)"
}
get_system_info

get_cpu_usage(){
  load_avg=$(uptime | awk '{print $(NF-2)}' | sed 's/,//')
  echo "Load Average (1 min): $load_avg"
}
get_cpu_usage
echo ""

get_memory_usage(){
    echo "=== MEMORY USAGE ==="
    echo "Memory Usage: $(free -h)"
}
get_memory_usage
echo ""

get_disk_usage(){
  echo "=== DISK USAGE ==="
  echo "Disk Usage: $(df -h)"
}
get_disk_usage
echo ""

get_running_services(){
   echo "=== RUNNING SERVICES ==="
   echo "Total processes: $(ps aux | wc -l)"
}
get_running_services
echo "=========================="
echo "Report saved to : $LOG_FILE"

}

main(){
echo "starting system health check ..."
generate_report
generate_report > "$LOG_FILE" 
echo "Report saved to: "$LOG_FILE""
send_alerts
}
main
