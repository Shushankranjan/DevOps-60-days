# System Health Monitor - Day 1 DevOps Foundation Project

## Project Description

The System Health Monitor is a comprehensive bash-based monitoring tool developed as part of Day 1 DevOps Foundation learning. This project demonstrates essential Linux command mastery and DevOps thinking by creating a real-world system monitoring solution that mirrors production tools like Nagios plugins or AWS CloudWatch custom metrics.

This tool embodies core DevOps principles: automation over manual work, monitoring over hoping, and treating infrastructure as code. The monitor continuously collects system metrics including CPU usage, memory consumption, disk space, network connections, and running services, providing the foundation for proactive system management that Site Reliability Engineers and DevOps Engineers use daily.

Key features include:
- Comprehensive system health metrics collection
- Configurable alert thresholds with color-coded output
- Automated logging with timestamped reports
- Real-time monitoring dashboard capabilities
- Multi-server monitoring via SSH
- Production-ready architecture following DevOps best practices

## Prerequisites

To run the System Health Monitor, ensure your environment meets these requirements:

- **Operating System**: Linux (Ubuntu 18.04+, CentOS 7+, RHEL 7+, or compatible distributions)
- **Shell**: Bash 4.0 or higher (verify with `bash --version`)
- **Essential System Tools**: 
  - Core utilities: `uname`, `lscpu`, `free`, `df`, `ps`, `uptime`, `whoami`
  - Network tools: `netstat`, `ss`, `ping`, `curl`
  - File operations: `ls`, `find`, `grep`, `chmod`, `chown`
  - Process management: `top`, `kill`, `nohup`
  - Monitoring tools: `iostat`, `vmstat`, `sar`, `lsof` (optional but recommended)
- **Permissions**: Standard user permissions (sudo required for some system metrics)
- **Storage**: Minimum 50MB free disk space for logs and configuration
- **Network**: Internet connectivity for remote monitoring features

**Verify Prerequisites:**
```bash
# Check bash version
bash --version

# Verify essential commands
which uname lscpu free df ps netstat uptime
```

## Installation

Follow these steps to set up the System Health Monitor:

1. **Clone the repository and set up directory structure**:
   ```bash
   git clone https://github.com/yourusername/day01_system_monitor.git
   cd day01_system_monitor
   ```

2. **Run the installation script**:
   ```bash
   chmod +x scripts/install.sh
   ./scripts/install.sh
   ```

3. **Configure monitoring settings**:
   ```bash
   # Edit main configuration
   nano config/monitor.conf
   
   # Configure alert thresholds
   nano config/alerts.conf
   ```

4. **Make the main script executable**:
   ```bash
   chmod +x src/system_monitor.sh
   ```

5. **Test the installation**:
   ```bash
   ./src/system_monitor.sh --test
   ```

The installation script automatically creates the required directory structure:
```
day01_system_monitor/
├── src/                  # Source code
├── config/              # Configuration files
├── logs/                # Log files directory
├── docs/                # Documentation
├── scripts/             # Installation scripts
└── examples/            # Sample outputs and configs
```

## Usage Examples

### Basic Usage

**Run a complete system health check**:
```bash
./src/system_monitor.sh
```

**Generate a detailed report**:
```bash
./src/system_monitor.sh --report --output logs/health_report_$(date +%Y%m%d).txt
```

**Check specific metrics only**:
```bash
./src/system_monitor.sh --cpu --memory --disk
```

### Advanced Options

**Real-time monitoring dashboard** (refreshes every 5 seconds):
```bash
./src/system_monitor.sh --dashboard --interval 5
```

**Monitor with custom thresholds**:
```bash
./src/system_monitor.sh --cpu-threshold 75 --memory-threshold 80 --disk-threshold 85
```

**Enable color-coded output**:
```bash
./src/system_monitor.sh --color --dashboard
```

**Multi-server monitoring via SSH**:
```bash
./src/system_monitor.sh --remote-servers "server1,server2,server3" --ssh-key ~/.ssh/monitor_key
```

### Automation Setup

**Set up automated monitoring with cron**:
```bash
# Add to crontab for monitoring every 5 minutes
*/5 * * * * /path/to/day01_system_monitor/src/system_monitor.sh --silent --log

# Generate daily health reports
0 6 * * * /path/to/day01_system_monitor/src/system_monitor.sh --report --email admin@company.com
```

**Integration with system startup**:
```bash
# Add to /etc/rc.local for startup monitoring
/path/to/day01_system_monitor/src/system_monitor.sh --startup-check
```

## Configuration

### Main Configuration (config/monitor.conf)

```bash
# System Monitoring Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=85
DISK_THRESHOLD=90

# Monitoring Intervals
CHECK_INTERVAL=300          # 5 minutes for regular checks
DASHBOARD_REFRESH=5         # 5 seconds for real-time dashboard

# Logging Configuration
LOG_DIRECTORY="logs"
LOG_RETENTION_DAYS=30
ENABLE_DETAILED_LOGGING=true

# Alert Configuration
ENABLE_ALERTS=true
ALERT_SOUND=false
COLOR_OUTPUT=true

# Network Monitoring
NETWORK_TIMEOUT=10
PING_TARGETS="8.8.8.8,google.com"
CHECK_PORTS="80,443,22"
```

### Alert Configuration (config/alerts.conf)

```bash
# Email Alerts
EMAIL_ALERTS=false
EMAIL_RECIPIENTS="admin@company.com"
SMTP_SERVER="localhost"

# Alert Thresholds (Override main config if needed)
CRITICAL_CPU_THRESHOLD=95
CRITICAL_MEMORY_THRESHOLD=95
CRITICAL_DISK_THRESHOLD=98

# Alert Conditions
ALERT_ON_HIGH_LOAD=true
ALERT_ON_DISK_FULL=true
ALERT_ON_SERVICE_DOWN=true
ALERT_ON_NETWORK_FAILURE=true

# Monitored Services
CRITICAL_SERVICES="ssh,networking,cron"
OPTIONAL_SERVICES="apache2,nginx,mysql"
```

### Command Line Options

```bash
# Basic Operations
--test                    # Test installation and dependencies
--report                  # Generate detailed report
--dashboard              # Launch real-time monitoring dashboard
--silent                 # Run without output (for cron jobs)

# Metric Selection
--cpu                    # Check CPU usage only
--memory                 # Check memory usage only
--disk                   # Check disk usage only
--network               # Check network connectivity only
--services              # Check running services only

# Customization
--cpu-threshold VALUE    # Set custom CPU alert threshold
--memory-threshold VALUE # Set custom memory alert threshold
--disk-threshold VALUE   # Set custom disk alert threshold
--interval SECONDS       # Set dashboard refresh interval
--color                 # Enable color-coded output
--no-color              # Disable color output

# Advanced Features
--remote-servers LIST    # Monitor remote servers via SSH
--ssh-key PATH          # SSH key for remote monitoring
--output FILE           # Save output to specific file
--email ADDRESS         # Send report via email
```

## Troubleshooting

### Permission Issues

**Problem**: Permission denied when accessing system files
```bash
./system_monitor.sh: line 45: /proc/stat: Permission denied
```
**Solution**: Some system metrics require elevated privileges:
```bash
# Run with sudo for complete system access
sudo ./src/system_monitor.sh

# Or adjust script to handle permission gracefully
```

**Problem**: Cannot write to log directory
**Solution**: Check directory permissions:
```bash
chmod 755 logs/
# Or create logs directory if missing
mkdir -p logs
```

### Missing Commands

**Problem**: Command not found errors
```bash
./system_monitor.sh: line 23: iostat: command not found
```
**Solution**: Install required system monitoring tools:
```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install sysstat net-tools procps

# CentOS/RHEL
sudo yum install sysstat net-tools procps-ng

# Or using dnf (newer versions)
sudo dnf install sysstat net-tools procps-ng
```

**Problem**: SSH remote monitoring fails
**Solution**: Set up SSH key authentication:
```bash
# Generate SSH key pair
ssh-keygen -t rsa -b 2048 -f ~/.ssh/monitor_key

# Copy public key to remote servers
ssh-copy-id -i ~/.ssh/monitor_key.pub user@remote-server
```

### Log Locations

**Primary log files**:
- `logs/system_health_YYYYMMDD_HHMMSS.log` - Main monitoring logs
- `logs/alerts.log` - Alert history
- `logs/errors.log` - Error messages and debugging info

**Analyzing logs**:
```bash
# View recent monitoring data
tail -f logs/system_health_*.log

# Search for specific alerts
grep "CRITICAL" logs/alerts.log

# Check error patterns
grep "ERROR\|FAIL" logs/errors.log
```

**Debug mode**:
```bash
# Enable verbose output for troubleshooting
./src/system_monitor.sh --debug --test
```

### Common Issues

**High CPU usage from monitoring script**:
- Increase `CHECK_INTERVAL` in config
- Reduce dashboard refresh rate
- Use `--silent` mode for background monitoring

**Network connectivity checks failing**:
- Verify firewall settings
- Check DNS resolution: `nslookup google.com`
- Test manual connectivity: `ping -c 4 8.8.8.8`

**Remote server monitoring issues**:
- Verify SSH key permissions: `chmod 600 ~/.ssh/monitor_key`
- Test manual SSH connection: `ssh -i ~/.ssh/monitor_key user@server`
- Check firewall rules on remote servers

## What I Learned

Building this System Health Monitor as part of Day 1 DevOps Foundation provided hands-on experience with core concepts:

**Linux Command Mastery**: Gained proficiency with essential system commands including `uname`, `lscpu`, `free`, `df`, `ps`, `netstat`, and `uptime`. Learned to parse command outputs, handle different Linux distributions, and combine commands for comprehensive system analysis. Understanding these commands is crucial since 96% of servers run Linux, and command line mastery is non-negotiable for DevOps professionals.

**DevOps Monitoring Concepts**: Experienced the shift from reactive to proactive system management. Learned to identify meaningful metrics versus noise, set appropriate alert thresholds to avoid alert fatigue, and implement monitoring that follows the DevOps principle of "monitoring over hoping." This mirrors how Site Reliability Engineers handle incident response and how Infrastructure Engineers manage server health.

**Infrastructure as Code Mindset**: Developed scripts that treat servers as "cattle, not pets" - standardized, replaceable, and manageable through code. This approach is fundamental to modern DevOps practices where infrastructure is version-controlled, repeatable, and scalable.

**Automation Philosophy**: Implemented the core DevOps principle of "automation over manual work" by creating tools that eliminate repetitive tasks. This hands-on experience demonstrates why DevOps Engineers focus on building systems that scale and reduce human error.

**Real-world Application**: Built a tool that mirrors production monitoring solutions like Nagios plugins or AWS CloudWatch custom metrics, providing practical experience with industry-standard monitoring approaches.

## Next Steps

Future enhancements planned for the System Health Monitor:

### Integration with Alerting Systems
- **Slack Integration**: Implement webhook notifications for real-time alerts in team channels
- **PagerDuty Integration**: Add incident management capabilities for critical system failures
- **Email Notifications**: Enhance SMTP integration with HTML reports and attachment support
- **SMS Alerts**: Integrate with services like Twilio for critical alert notifications

### Database Storage
- **Time-Series Database**: Store metrics in InfluxDB for historical analysis and trending
- **SQLite Integration**: Local database storage for offline analysis and reporting
- **Data Visualization**: Create web-based dashboards using Grafana for metric visualization
- **Capacity Planning**: Implement trend analysis for proactive infrastructure scaling

### Advanced Monitoring Features
- **Container Monitoring**: Extend support for Docker containers and Kubernetes pods
- **Application Monitoring**: Add support for monitoring specific applications and services
- **Log Analysis**: Integrate log parsing and analysis for comprehensive system insights
- **Performance Baseline**: Establish performance baselines and anomaly detection

### Production Deployment
- **Systemd Service**: Convert to proper systemd service for production deployment
- **Configuration Management**: Integration with Ansible, Puppet, or Chef for enterprise deployment
- **API Development**: Create REST API for programmatic access and integration
- **High Availability**: Implement redundancy and failover capabilities for critical monitoring

This Day 1 project provides a solid foundation for advanced DevOps monitoring concepts and serves as a stepping stone toward enterprise-grade infrastructure management tools.
