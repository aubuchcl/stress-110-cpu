#!/bin/sh

# Default to 1 CPU if CPU_COUNT is not set
CPU_COUNT=${CPU_COUNT:-1}

# Stress the specified number of CPUs at 110% load each
# 110% is simulated by overcommitting the number of workers (e.g., n * 1.1)
WORKER_COUNT=$(echo "$CPU_COUNT * 1.1" | bc | awk '{print int($1+0.5)}')

# Function to handle SIGINT
handle_sigint() {
    echo "SIGINT received, stopping stress test..."
    pkill -SIGINT stress-ng
    exit 0
}

# Trap SIGINT signal and call handle_sigint
trap 'handle_sigint' SIGINT

# Execute stress-ng for 10 minutes
stress-ng --cpu "$CPU_COUNT" --cpu-load 100 --cpu-method all --timeout 600s &
stress-ng --cpu $(($WORKER_COUNT - $CPU_COUNT)) --cpu-load 10 --cpu-method all --timeout 600s

# Wait for all background processes to finish
wait