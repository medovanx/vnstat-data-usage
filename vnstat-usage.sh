#!/bin/bash

# Check if the user provided two arguments (start date and end date)
if [ $# -ne 2 ]; then
  echo "Usage: $0 <start-date> <end-date>"
  echo "Example: $0 2024-09-20 2024-09-27"
  exit 1
fi

start_date=$1
end_date=$2

# Check if vnstat is installed
if ! command -v vnstat &> /dev/null; then
  echo "[~] vnstat is not installed. Installing vnstat..."
  
  # Check if the script is run as root or with sudo
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root to install vnstat."
    exit 1
  fi
  
  # Install vnstat
  if [ -x "$(command -v apt)" ]; then
    apt update && apt install -y vnstat
  elif [ -x "$(command -v yum)" ]; then
    yum install -y vnstat
  elif [ -x "$(command -v dnf)" ]; then
    dnf install -y vnstat
  else
    echo "Package manager not supported. Please install vnstat manually."
    exit 1
  fi
  
  echo "[~] vnstat installed successfully."
fi

# This script filters and formats vnstat output for a user-specified date range and displays total data usage in GiB
vnstat -d | awk -v start="$start_date" -v end="$end_date" 'BEGIN {
    printf "%-12s | %-10s | %-10s\n", "Day", "Total", "Cumulative";
    print "-------------|------------|------------"
} 
{
    # Compare dates and ensure they are within the range
    if ($1 >= start && $1 <= end) {
        # Convert values to GiB for cumulative sum
        if ($9 == "GiB") {
            total = $8;
        } else {
            total = $8 / 1024;  # Convert MiB to GiB
        }
        cumulative += total;
        printf "%-12s | %6.2f GiB  | %10s\n", $1, total, ""
    }
}
END {
    printf "-------------|------------|------------\n";
    printf "%-12s | %-10s | %6.2f GiB\n", "Total", "", cumulative
}'
