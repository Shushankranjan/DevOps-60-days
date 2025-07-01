#!/bin/bash
# Simple test for system_monitor.sh

echo "========================================="
echo "TESTING SYSTEM MONITOR"
echo "========================================="

# Test 1: Run the monitor normally
echo "Test 1: Normal execution"
echo "Running: ./src/system_monitor.sh"
./src/system_monitor.sh
echo ""

# Test 2: Check if log file was created
echo "Test 2: Checking log file creation"
latest_log=$(ls -t logs/system_health_*.log 2>/dev/null | head -1)
if [ -f "$latest_log" ]; then
    echo "✓ Log file created: $latest_log"
    echo "✓ File size: $(stat -c%s "$latest_log") bytes"
    echo "✓ Line count: $(wc -l < "$latest_log") lines"
else
    echo "✗ No log file found!"
fi
echo ""

# Test 3: Show log content
echo "Test 3: Log file content"
if [ -f "$latest_log" ]; then
    echo "--- Content of $latest_log ---"
    cat "$latest_log"
else
    echo "No log file to display"
fi
echo ""

# Test 4: Run multiple times to test unique filenames
echo "Test 4: Testing multiple runs (unique filenames)"
echo "Running monitor 3 times with 2-second delays..."
for i in {1..3}; do
    echo "  Run $i..."
    ./src/system_monitor.sh
    sleep 2
done

echo "Log files created:"
ls -la logs/system_health_*.log
echo ""

# Test 5: Manual verification
echo "Test 5: Manual verification of metrics"
echo "Compare these manual results with your log files:"
echo ""
echo "Manual hostname: $(hostname)"
echo "Manual load: $(uptime | awk '{print $(NF-2)}' | sed 's/,//')"
echo "Manual processes: $(ps aux | wc -l)"
echo ""
echo "Manual memory:"
free -h
echo ""
echo "Manual disk:"
df -h

echo ""
echo "========================================="
echo "TESTING COMPLETE"
echo "========================================="